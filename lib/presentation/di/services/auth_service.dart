import 'dart:developer';
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
                if (userData == null) {
                  return;
                }
                if (listener != null) {
                  listener(p0);
                }
                log(userData.role.toString());
                _userStore.setSelectedUser(userData, accessToken: token);
                final profile = userData.getProfiles();
                if (profile[0].id >= 0) {
                  _userStore.setSelectedType(profile[0].type);
                } else if (profile[1].id >= 0) {
                  _userStore.setSelectedType(profile[1].type);
                } else {
                  _userStore.setSelectedType(AccountType.none);
                }
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
      log("Sign up status: ${value.statusCode} ${value.data}");
      if (listener != null) {
        listener(value);
      }
    });
  }

  void forgotPassword({
    required String email,
    void Function(Response<dynamic> res)? listener,
  }) {
    _dioClient.dio
        .post(
      Endpoints.forgotPwd,
      data: {"email": email},
      options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (status) => true,
      ),
    )
        .then((v) {
      if (listener != null) listener(v);
    });
  }

  void changePassword({
    required String oldPwd,
    required String newPwd,
    void Function(Response<dynamic> res)? listener,
  }) {
    _dioClient.dio
        .put(
      Endpoints.changePwd,
      data: {"oldPassword": oldPwd, "newPassword": newPwd},
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (status) => true,
      ),
    )
        .then((res) {
      if (listener != null) listener(res);
    });
  }
}
