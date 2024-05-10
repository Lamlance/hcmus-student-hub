import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/interview_api_models.dart';
import 'package:boilerplate/data/models/message_api_model.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';
export "package:boilerplate/data/models/interview_api_models.dart";
export 'package:boilerplate/data/models/message_api_model.dart';

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

  void getAllInterviews(
      {void Function(Response<dynamic> res, List<InterviewData>? data)?
          listener}) {
    _dioClient.dio
        .get(
      Endpoints.getInterviews,
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token}'},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (res) => true,
      ),
    )
        .then(
      (value) {
        if (listener == null) return;
        if (value.statusCode != 200) return listener(value, null);
        listener(
          value,
          (value.data["result"] as List<dynamic>)
              .map(
                (e) => InterviewData.fromJson(e),
              )
              .toList(),
        );
      },
    );
  }

  void createInterview(CreateInterviewRequest data) {
    _dioClient.dio
        .post(
      Endpoints.createInterview,
      data: data,
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token}'},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (res) => true,
      ),
    )
        .then((value) {
      log("Create interview: ${value.statusCode},${value.data}");
    });
  }

  void getDetailInterview({
    required int interviewId,
    void Function(Response res, InterviewData? data)? listener,
  }) {
    _dioClient.dio
        .get(
      Endpoints.getDetailInterview(interviewId),
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token}'},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (res) => true,
      ),
    )
        .then((v) {
      if (listener == null) return;
      if (v.statusCode != 200) return listener(v, null);

      return listener(v, InterviewData.fromJson(v.data["result"]));
    });
  }
}
