import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';

typedef ListenerCallback = void Function({required Response response});

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

  Future<void> postProject(
      {required Map<String, dynamic> projectData,
      ListenerCallback? listener}) async {
    try {
      var response = await _dioClient.dio.post(
        Endpoints.postProject,
        data: projectData,
        options: Options(
          headers: {"authorization": 'Bearer ${_userStore.token ?? ""}'},
        ),
      );

      if (response.statusCode != 200) {
        if (listener != null) listener(response: response);
        return;
      }

      final project = ProjectData.fromJson(response.data["result"]);
      _dashBoardStore.addProjects([project]);
    } catch (e) {
      // Handle any errors here
    }
  }
}
