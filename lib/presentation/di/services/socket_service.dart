import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/interview_api_models.dart';
import 'package:boilerplate/data/models/socket_api_models.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/presentation/di/services/notification_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import "dart:developer";
export "package:boilerplate/data/models/socket_api_models.dart";

typedef ReceiveMsgCallback = Function(SocketReceiveMessageEvent? data);

class SocketChatService {
  static const _receiveMsgEventName = "RECEIVE_MESSAGE";
  static const _sendMsgEmitName = "SEND_MESSAGE";
  static const _sendInterviewEmitName = "SCHEDULE_INTERVIEW";

  final UserStore _userStore;
  final LocalNotificationService _notificationService;
  int? currUserId;

  final socket = IO.io(
      Endpoints.socketUrl,
      IO.OptionBuilder()
          .setTransports(["websocket"])
          .disableAutoConnect()
          .build());

  final _notiSocket = IO.io(
      Endpoints.socketUrl,
      IO.OptionBuilder()
          .setTransports(["websocket"])
          .disableAutoConnect()
          .build());

  ReceiveMsgCallback? onReceiveMsg;

  SocketChatService(
      {required UserStore userStore,
      required LocalNotificationService notificationService})
      : _userStore = userStore,
        _notificationService = notificationService {
    socket.onConnect((data) => log("On socket connect"));
    socket.onError((data) => log("On socket error"));
    socket.on(_receiveMsgEventName, _receiveMsgCallback);

    _notiSocket.onConnect((data) => log("On notification socket connect"));
    _notiSocket.onError((data) => log("On notification socket error"));
  }

  void _receiveMsgCallback(dynamic data) {
    final msgData = SocketReceiveMessageEvent.tryFromJson(data);
    if (onReceiveMsg != null) onReceiveMsg!(msgData);
  }

  void _handleNotification(dynamic data) {
    log("Get notfication");
    _notificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch % 100,
      title: "Got notification",
      body: "Noti noti noti",
    );
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

  void connectToNotification(int userId) {
    _notiSocket.io.options?["extraHeaders"] = {
      "Authorization": 'Bearer ${_userStore.token}'
    };
    if (currUserId != userId) {
      _notiSocket.on("NOTI_$userId", _handleNotification);
      _notiSocket.off("NOTI_$currUserId");
      currUserId = userId;
      if (_notiSocket.connected == false) {
        _notiSocket.connect();
      } else {
        _notiSocket.close().connect();
      }
    } else if (_notiSocket.connected == false) {
      _notiSocket.connect();
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

  bool sendInterview(CreateInterviewRequest data) {
    if (socket.connected == false) return false;
    final senderId = _userStore.selectedUser?.userId;
    if (senderId == null) return false;

    socket.emit(_sendInterviewEmitName, data.toJson());

    return true;
  }

  void closeSocket() {
    socket.close();
  }
}
