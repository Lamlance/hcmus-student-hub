import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';

class PostProjectService {
  final DioClient _dioClient;
  final UserStore _userStore;
  final DashBoardStore _dashBoardStore;

  PostProjectService(
      {required DioClient dioClient,
      required UserStore userStore,
      required DashBoardStore dashBoardStore})
      : _dioClient = dioClient,
        _userStore = userStore,
        _dashBoardStore = dashBoardStore;

  void postProject(
      {required Map<String, dynamic> projectData,
      void Function({Response<dynamic>? response})? listener}) {
    _dioClient.dio
        .post(Endpoints.postProject,
            data: projectData,
            options: Options(
              headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
            ))
        .then((v) {
      if (v.statusCode != 200) {
        if (listener != null) listener(response: v);
        return;
      }
      final project = ProjectData.fromJson(v.data["result"]);
      _dashBoardStore.addProject(project);
    });
  }
}
