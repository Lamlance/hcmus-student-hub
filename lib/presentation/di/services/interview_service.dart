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
}
