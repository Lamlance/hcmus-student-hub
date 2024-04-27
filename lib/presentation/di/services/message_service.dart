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
}
