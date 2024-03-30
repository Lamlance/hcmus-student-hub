import 'dart:developer';
import 'dart:io';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/repository/auth_repo.dart';
import 'package:dio/dio.dart';

export 'package:boilerplate/data/repository/auth_repo.dart';

class AuthApi {
  final DioClient _dioClient;
  AuthApi({required DioClient dioClient}) : _dioClient = dioClient;

  void signIn(
      {required AuthApiSignInRequest data,
      void Function(Response<dynamic>)? listener}) {
    _dioClient.dio
        .post(
      Endpoints.signIn,
      data: data,
      options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (status) => true,
      ),
    )
        .then((value) {
      log("Sign in status: ${value.statusCode}");
      if (listener != null) {
        listener(value);
      }
    });
  }

  void signUp(
      {required AuthApiSignUpRequest data,
      void Function(Response<dynamic>)? listener}) {
    _dioClient.dio
        .post(
      Endpoints.signUp,
      data: data,
      options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (status) => true,
      ),
    )
        .then((value) {
      log("Sign up status: ${value.statusCode}");
      if (listener != null) {
        listener(value);
      }
    });
  }
}
