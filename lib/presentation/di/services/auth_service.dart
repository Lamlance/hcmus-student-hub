import 'dart:developer';
import 'dart:io';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/models/auth_api_models.dart';
import 'package:dio/dio.dart';

export 'package:boilerplate/data/models/auth_api_models.dart';

class AuthService {
  final DioClient _dioClient;
  final UserStore _userStore;

  AuthService({required DioClient dioClient, required UserStore userStore})
      : _dioClient = dioClient,
        _userStore = userStore;

  void authMe(
      {required String token,
      void Function(Response<dynamic>, UserData? userData)? listener}) {
    _dioClient.dio
        .get(
      Endpoints.authMe,
      options: Options(
        headers: {"authorization": 'Bearer $token'},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (status) => true,
      ),
    )
        .then((value) {
      UserData? userData;
      if (value.statusCode == 200) {
        userData = UserData.fromJson(value.data["result"]);
      }
      if (listener != null) {
        listener(value, userData);
      }
    });
  }

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
      if (value.data != null && value.statusCode == 201) {
        String? token = value.data["result"]["token"];
        if (token != null) {
          return authMe(
              token: token,
              listener: (p0, userData) {
                if (listener != null) {
                  listener(p0);
                }
                log(userData?.role.toString() ?? "No id");
                _userStore.setSelectedUser(userData, accessToken: token);
                final profile =
                    userData?.getProfiles().firstWhere((e) => e.id >= 0);
                _userStore.setSelectedType(profile?.type ?? AccountType.none);
              });
        }
      }
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
