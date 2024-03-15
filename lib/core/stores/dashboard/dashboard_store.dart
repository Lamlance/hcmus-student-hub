import 'package:mobx/mobx.dart';
part 'dashboard_store.g.dart';

enum ProjectStatus { none, working, archive }

enum HireStatus { propose, activePropose, sentHire, hired }

class ProjectData {
  final int id;
  final String title;
  final int monthTime;
  final int numberOfStudent;
  final String description;
  late DateTime createdDate;
  ProjectStatus status = ProjectStatus.none;
  HireStatus? hireStatus;

  int proposalCount = 3;
  int messageCount = 2;
  int hiredCount = 1;

  ProjectData(
      {required this.id,
      this.title = "title",
      this.monthTime = 3,
      this.numberOfStudent = 5,
      this.description = "description",
      this.status = ProjectStatus.none,
      this.proposalCount = 3,
      this.messageCount = 2,
      this.hiredCount = 1,
      this.hireStatus,
      DateTime? createdDate}) {
    this.createdDate = createdDate ?? DateTime.now();
  }
}

class DashBoardStore = _DashBoardStore with _$DashBoardStore;

abstract class _DashBoardStore with Store {
  @observable
  ProjectData? selectedProject;

  // @observable
  // List<ProjectData> projects = List.empty(growable: true);

  @observable
  List<ProjectData> projects = [
    ProjectData(
        id: 1,
        status: ProjectStatus.none,
        hireStatus: HireStatus.activePropose,
        title: "Junior level frontend",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ullamcorper est ligula, a hendrerit odio ullamcorper vel. Etiam tristique ligula ut imperdiet fringilla. Suspendisse potenti. Donec maximus eros sit amet lacinia mollis. Maecenas non tincidunt nisi. Nunc molestie velit sed tempus mattis. Duis vehicula, sem quis tincidunt maximus, leo lorem accumsan risus, sed volutpat orci purus vel mi. Nulla quis aliquet nisi. "),
    ProjectData(
        id: 2,
        status: ProjectStatus.none,
        title: "Senior backend",
        hireStatus: HireStatus.propose,
        numberOfStudent: 4,
        hiredCount: 4,
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ullamcorper est ligula, a hendrerit odio ullamcorper vel. Etiam tristique ligula ut imperdiet fringilla. Suspendisse potenti. Donec maximus eros sit amet lacinia mollis. Maecenas non tincidunt nisi. Nunc molestie velit sed tempus mattis. Duis vehicula, sem quis tincidunt maximus, leo lorem accumsan risus, sed volutpat orci purus vel mi. Nulla quis aliquet nisi. "),
    ProjectData(
        id: 3,
        status: ProjectStatus.working,
        hireStatus: HireStatus.propose,
        title: "Fresher data science",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ullamcorper est ligula, a hendrerit odio ullamcorper vel. Etiam tristique ligula ut imperdiet fringilla. Suspendisse potenti. Donec maximus eros sit amet lacinia mollis. Maecenas non tincidunt nisi. Nunc molestie velit sed tempus mattis. Duis vehicula, sem quis tincidunt maximus, leo lorem accumsan risus, sed volutpat orci purus vel mi. Nulla quis aliquet nisi. "),
    ProjectData(
        id: 4,
        status: ProjectStatus.archive,
        title: "Fresher Go dev",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ullamcorper est ligula, a hendrerit odio ullamcorper vel. Etiam tristique ligula ut imperdiet fringilla. Suspendisse potenti. Donec maximus eros sit amet lacinia mollis. Maecenas non tincidunt nisi. Nunc molestie velit sed tempus mattis. Duis vehicula, sem quis tincidunt maximus, leo lorem accumsan risus, sed volutpat orci purus vel mi. Nulla quis aliquet nisi. ")
  ];

  @action
  addProjects(Iterable<ProjectData> datas) {
    projects.addAll(datas);
  }

  @action
  setSelectProject(ProjectData? data) {
    selectedProject = data;
  }

  @action
  bool updateProject(ProjectData data) {
    var itemIdx = projects.indexWhere((e) => data.id == e.id);
    if (itemIdx < 0) return false;
    projects[itemIdx] = data;
    return true;
  }
}
