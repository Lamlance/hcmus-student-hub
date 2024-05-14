import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/message_api_model.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';

class MessageService {
  final DioClient _dioClient;
  final UserStore _userStore;

  MessageService({required DioClient dioClient, required UserStore userStore})
      : _dioClient = dioClient,
        _userStore = userStore;

  void getMyMessage(
      {void Function(Response<dynamic> res, GetMyMessageRespond? msgs)?
          listener}) {
    _dioClient.dio
        .get(Endpoints.getMyMessage,
            options: Options(
              validateStatus: (s) => true,
              headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
            ))
        .then((res) {
      if (res.statusCode != 200) {
        if (listener != null) listener(res, null);
        return;
      }
      if (listener != null) {
        listener(res, GetMyMessageRespond.fromJson(res.data));
      }
    });
  }

  void getMessageOfProject({
    required int projectId,
    void Function(Response<dynamic> res, GetProjectMessageRespond? msgs)?
        listener,
  }) {
    _dioClient.dio
        .get(
      Endpoints.getProjectMessage(projectId),
      options: Options(
        validateStatus: (s) => true,
        headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
      ),
    )
        .then((res) {
      if (res.statusCode != 200) {
        if (listener != null) listener(res, null);
        return;
      }
      if (listener != null) {
        listener(res, GetProjectMessageRespond.fromJson(res.data));
      }
    });
  }

  void getMyMessageWith({
    required int projectId,
    required int targetId,
    Function(Response<dynamic> res, List<MessageData>? data)? listener,
  }) {
    _dioClient.dio
        .get(Endpoints.getMyMessageWith(projectId, targetId),
            options: Options(
              headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
            ))
        .then((v) {
      if (listener != null) {
        return listener(
          v,
          v.statusCode != 200
              ? null
              : (v.data["result"] as List<dynamic>)
                  .map((e) => MessageData.fromJson(e))
                  .toList(),
        );
      }
    });
  }
}
