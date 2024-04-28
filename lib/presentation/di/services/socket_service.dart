import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/socket_api_models.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import "dart:developer";
export "package:boilerplate/data/models/socket_api_models.dart";

typedef ReceiveMsgCallback = Function(SocketReceiveMessageEvent? data);

class SocketChatService {
  static const _receiveMsgEventName = "RECEIVE_MESSAGE";
  static const _sendMsgEmitName = "SEND_MESSAGE";
  final UserStore _userStore;
  final socket = IO.io(
      Endpoints.socketUrl,
      IO.OptionBuilder()
          .setTransports(["websocket"])
          .disableAutoConnect()
          .build());

  ReceiveMsgCallback? onReceiveMsg;

  SocketChatService({required UserStore userStore}) : _userStore = userStore {
    socket.io.options?["extraHeaders"] = {
      "Authorization": 'Bearer ${_userStore.token}'
    };
    socket.onConnect((data) => log("On socket connect"));
    socket.onError((data) => log("On socket error"));
    socket.on(_receiveMsgEventName, _receiveMsgCallback);
  }

  void _receiveMsgCallback(dynamic data) {
    final msgData = SocketReceiveMessageEvent.tryFromJson(data);
    if (onReceiveMsg != null) onReceiveMsg!(msgData);
  }

  void connectToProject(int projectId, ReceiveMsgCallback listener) {
    final int? currProject = socket.io.options?["query"]?["project_id"];
    socket.io.options?["extraHeaders"] = {
      "Authorization": 'Bearer ${_userStore.token}'
    };
    onReceiveMsg = listener;
    if (currProject == null || currProject != projectId) {
      log("Connect with new project id");
      socket.io.options?["query"] = {"project_id": projectId};
      if (socket.connected == false) {
        socket.connect();
      } else {
        socket.close().connect();
      }
    } else if (!socket.connected) {
      socket.connect();
    }
  }

  bool sendMsg(
      {required String content,
      required int receiveId,
      required int projectId,
      SocketMsgFlag flag = SocketMsgFlag.none}) {
    if (socket.connected == false) return false;

    final senderId = _userStore.selectedUser?.userId;
    if (senderId == null) return false;

    final msg = SocketSendMessageRequest(
        projectId: projectId,
        content: content,
        senderId: senderId,
        receiveId: receiveId,
        messageFlag: flag);
    socket.emit(_sendMsgEmitName, msg.toJson());
    return true;
  }

  void closeSocket() {
    socket.close();
  }
}
