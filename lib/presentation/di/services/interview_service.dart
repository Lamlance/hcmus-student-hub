import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/interview_api_models.dart';
import 'package:boilerplate/data/models/message_api_model.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';
export "package:boilerplate/data/models/interview_api_models.dart";

class InterviewService {
  final DioClient _dioClient;
  final UserStore _userStore;

  InterviewService({required DioClient dioClient, required UserStore userStore})
      : _dioClient = dioClient,
        _userStore = userStore;

  void cancelInterview({
    required int interviewId,
    Function(Response<dynamic> res)? listener,
  }) {
    _dioClient.dio
        .patch(
      Endpoints.cancelInterview(interviewId),
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token}'},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    )
        .then((value) {
      if (listener != null) listener(value);
    });
  }

  void editInterview({
    required int interviewId,
    required DateTime startTime,
    required DateTime endTime,
    required String title,
    Function(Response<dynamic> res)? listener,
  }) {
    _dioClient.dio.patch(
      Endpoints.editInterview(interviewId),
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token}'},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
      data: {
        "title": title,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
      },
    ).then((value) {
      if (listener != null) listener(value);
    });
  }
}
