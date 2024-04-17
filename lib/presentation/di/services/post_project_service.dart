import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/post_project_api_model.dart';
import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';
export 'package:boilerplate/data/models/proposal_api_models.dart';

typedef ListenerCallback = void Function(Response response);

class PostProjectService {
  final DioClient _dioClient;
  final UserStore _userStore;
  final DashBoardStore _dashBoardStore;

  PostProjectService({
    required DioClient dioClient,
    required UserStore userStore,
    required DashBoardStore dashBoardStore,
  })  : _dioClient = dioClient,
        _userStore = userStore,
        _dashBoardStore = dashBoardStore;

  void postProject(
      {required PostProjectApiModel data, ListenerCallback? listener}) {
    _dioClient.dio
        .post(
      Endpoints.postProject,
      data: data,
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
      ),
    )
        .catchError((res) {
      log("Post project error");
    }).then((value) {
      if (value.statusCode != 200) {
        if (listener != null) listener(value);
        return;
      }
      final project = ProjectData.fromJson(value.data["result"]);
      _dashBoardStore.addProjects([project]);
    });
  }
}
