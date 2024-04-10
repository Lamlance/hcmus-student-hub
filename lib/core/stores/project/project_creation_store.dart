import 'package:boilerplate/presentation/di/services/post_project_service.dart';
import 'package:boilerplate/data/models/post_project_api_model.dart';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';

class ProjectCreationStore {
  final PostProjectApiModel projectModel = PostProjectApiModel(
    companyId: 0,
    projectScopeFlag: 0,
    title: '',
    numberOfStudents: 0,
    description: '',
    typeFlag: 0,
    tags: [],
  );

  final DioClient dioClient;
  final UserStore userStore;
  final DashBoardStore dashBoardStore;

  ProjectCreationStore({
    required this.dioClient,
    required this.userStore,
    required this.dashBoardStore,
  });

  void updateCompanyId(int companyId) {
    projectModel.companyId = companyId;
  }

  // ... other update methods

  Future<void> postProject() async {
    await PostProjectService(
      dioClient: dioClient,
      userStore: userStore,
      dashBoardStore: dashBoardStore,
    ).postProject(projectData: projectModel.toJson());
  }
}
