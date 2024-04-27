import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';

export 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';

class GetProjectService {
  final DioClient _dioClient;
  final UserStore _userStore;
  final DashBoardStore _dashBoardStore;

  GetProjectService(
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
}
