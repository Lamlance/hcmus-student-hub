import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/message_api_model.dart';
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
  void getProjectsByCompanyId(
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

  void getAllProjects({
    String? filterTitle,
    int? filterDuration,
    int? filterNumberOfStudent,
    void Function(
      Response<dynamic>? response,
      List<ProjectData>? data,
    )? listener,
  }) {
    final query = Map<String, String>();
    if (filterTitle != null) {
      query["title"] = filterTitle;
    }
    if (filterDuration != null) {
      query["projectScopeFlag"] = filterDuration.toString();
    }
    if (filterNumberOfStudent != null) {
      query["numberOfStudents"] = filterNumberOfStudent.toString();
    }

    _dioClient.dio
        .get(Endpoints.getAllProjects,
            queryParameters: query,
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

  void getAllFavProjects({
    void Function(Response<dynamic>? response, List<ProjectData>? data)?
        listener,
  }) {
    if (_userStore.selectedUser?.student == null) {
      if (listener != null) listener(null, null);
      return;
    }

    _dioClient.dio
        .get(
      Endpoints.getFavProjects(_userStore.selectedUser!.student!.id),
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
        validateStatus: (status) => true,
      ),
    )
        .then((value) {
      if (listener == null) return;
      listener(
        value,
        value.statusCode != 200
            ? null
            : (value.data["result"] as List<dynamic>)
                .map((e) => ProjectData.fromJson(e["project"]))
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

  void makeProjectFav(
      {required int projectId,
      required bool isFavorite,
      void Function(Response<dynamic>? response)? listener}) {
    if (_userStore.selectedUser?.student == null) {
      if (listener != null) listener(null);
      return;
    }
    _dioClient.dio
        .patch(
      Endpoints.getFavProjects(_userStore.selectedUser!.student!.id),
      data: {
        "projectId": projectId,
        "disableFlag": isFavorite ? 0 : 1,
      },
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
        validateStatus: (status) => true,
      ),
    )
        .then((value) {
      if (listener != null) listener(value);
    });
  }

  void updateProject({
    required int projectId,
    required PostProjectApiModel data,
    void Function(Response<dynamic> res)? listener,
  }) {
    _dioClient.dio
        .patch(
      Endpoints.updateProject(projectId),
      data: data,
      options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
        validateStatus: (status) => true,
      ),
    )
        .then((v) {
      if (listener != null) listener(v);
    });
  }

  void startWorkingOnProject(
      {required ProjectData data, Function(Response<dynamic> res)? listener}) {
    _dioClient.dio
        .patch(
      Endpoints.updateProject(data.id),
      data: {
        "projectScopeFlag": 0,
        "title": data.title,
        "description": data.description,
        "numberOfStudents": data.numberOfStudent,
        "typeFlag": ProjectData.projectStatusToTypeFlagInt(data.status),
      },
      options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
        validateStatus: (status) => true,
      ),
    )
        .then((value) {
      if (listener != null) listener(value);
    });
  }

  void closeProject({
    required ProjectData data,
    required bool isSuccess,
    Function(Response<dynamic> res)? listener,
  }) {
    _dioClient.dio
        .patch(
      Endpoints.updateProject(data.id),
      data: {
        "projectScopeFlag": 0,
        "title": data.title,
        "description": data.description,
        "numberOfStudents": data.numberOfStudent,
        "typeFlag": 1,
        "status": isSuccess ? 1 : 2,
      },
      options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
        validateStatus: (status) => true,
      ),
    )
        .then((value) {
      if (listener != null) listener(value);
    });
  }

  void deleteProject({
    required int projectId,
    void Function(Response<dynamic> res)? listener,
  }) {
    _dioClient.dio
        .delete(
      Endpoints.deleteProject(projectId),
      options: Options(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
        validateStatus: (status) => true,
      ),
    )
        .then((v) {
      if (listener != null) listener(v);
    });
  }
}
