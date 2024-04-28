import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/interview_api_models.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';
export "package:boilerplate/data/models/interview_api_models.dart";

class InterviewService {
  final DioClient _dioClient;
  final UserStore _userStore;

  InterviewService({required DioClient dioClient, required UserStore userStore})
      : _dioClient = dioClient,
        _userStore = userStore;

  void createInterview({
    required CreateInterviewRequest data,
    void Function(Response<dynamic> res)? listener,
  }) {
    _dioClient.dio
        .post(Endpoints.createInterview,
            data: data,
            options: Options(
              headers: {"authorization": "Bearer ${_userStore.token}"},
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
              validateStatus: (status) => true,
            ))
        .then((value) {
      if (listener != null) listener(value);
    });
  }
}
