import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/project_api_models.dart';
import 'package:boilerplate/data/models/project_models.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';
import 'dart:developer';

export 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
export 'package:boilerplate/data/models/project_api_models.dart';
export 'package:boilerplate/data/models/project_models.dart';

typedef ListenerCallback = Function(Response<dynamic> res);

class ProjectService {
  final DioClient _dioClient;
  final UserStore _userStore;
  final DashBoardStore _dashBoardStore;

  ProjectService(
      {required DioClient dioClient,
      required UserStore userStore,
      required DashBoardStore dashBoardStore})
      : _dioClient = dioClient,
        _userStore = userStore,
        _dashBoardStore = dashBoardStore;
  getProjectsByCompanyId(
      {void Function(Response<dynamic>? response, List<ProjectData>? data)?
          listener}) {
    final companyId = _userStore.selectedUser?.company?.id;
    if (companyId == null) {
      if (listener != null) listener(null, null);
      return;
    }

    _dioClient.dio
        .get(Endpoints.getProjectsByCompanyId(companyId),
            options: Options(
              headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
              validateStatus: (status) => true,
            ))
        .then((v) {
      if (v.statusCode != 200) {
        if (listener != null) listener(v, null);
        return;
      }
      final projects = (v.data["result"] as List<dynamic>)
          .map((e) => ProjectData.fromJson(e))
          .toList();
      _dashBoardStore.replaceAllProject(projects);
      if (listener != null) listener(v, projects);
    });
  }

  getAllProjects(
      {void Function(Response<dynamic>? response, List<ProjectData>? data)?
          listener}) {
    _dioClient.dio
        .get(Endpoints.getAllProjects,
            options: Options(
              headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
              validateStatus: (status) => true,
            ))
        .then((value) {
      if (listener == null) return;
      listener(
        value,
        value.statusCode != 200
            ? null
            : (value.data["result"] as List<dynamic>)
                .map((e) => ProjectData.fromJson(e))
                .toList(),
      );
    });
  }

  void postProject(
      {required PostProjectApiModel data, ListenerCallback? listener}) {
    _dioClient.dio
        .post(
      Endpoints.postProject,
      data: data,
      options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
        validateStatus: (status) => true,
      ),
    )
        .then((value) {
      if (value.statusCode != 200) {
        if (listener != null) listener(value);
        return;
      }
      final project = ProjectData.fromJson(value.data["result"]);
      _dashBoardStore.addProjects([project]);
      if (listener != null) listener(value);
    }).catchError((err, stack) {
      log("Post project error");
      return null;
    });
  }
}
