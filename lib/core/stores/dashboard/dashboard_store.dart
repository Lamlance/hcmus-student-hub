import 'package:mobx/mobx.dart';
part 'dashboard_store.g.dart';

enum ProjectStatus { none, working, archive }

enum ProposalStatus { none, hired, hiredOfferSent, notHired }

class ProposalData {
  final int id;
  final int projectId;
  final int studentId;
  final String coverLetter;
  final ProposalStatus statusFlag;
  final bool isDisable;

  ProposalData(
      {required this.id,
      required this.projectId,
      required this.studentId,
      this.coverLetter = "",
      this.statusFlag = ProposalStatus.notHired,
      this.isDisable = false});
}

class ProjectData {
  final int id;
  final int companyId;
  final String title;
  final int numberOfStudent;
  final String description;
  final DateTime createdDate;
  final List<ProposalData> proposals;
  final int monthTime;
  ProjectStatus status = ProjectStatus.none;

  int proposalCount = 3;
  int messageCount = 2;
  int hiredCount = 1;

  ProjectData(
      {required this.id,
      required this.companyId,
      required this.title,
      this.numberOfStudent = 5,
      this.description = "description",
      this.status = ProjectStatus.none,
      this.messageCount = 2,
      List<ProposalData>? proposals,
      DateTime? createdDate})
      : createdDate = createdDate ?? DateTime.now(),
        proposals = proposals ?? List.empty(growable: true),
        hiredCount = (proposals ?? [])
            .where((e) => e.statusFlag == ProposalStatus.hired)
            .length,
        proposalCount = (proposals ?? [])
            .where((e) => e.statusFlag == ProposalStatus.none)
            .length,
        monthTime = (createdDate?.difference(DateTime.now()).inDays ?? 0) ~/ 30;

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
        id: json["id"],
        companyId: int.parse(json["companyId"].toString()),
        createdDate: DateTime.tryParse(json["createAt"] ?? ""),
        title: json["title"],
        description: json["description"]);
  }
}

class DashBoardStore = _DashBoardStore with _$DashBoardStore;

abstract class _DashBoardStore with Store {
  @observable
  ProjectData? selectedProject;

  // @observable
  // List<ProjectData> projects = List.empty(growable: true);

  @observable
  List<ProjectData> projects = [];

  @action
  addProjects(Iterable<ProjectData> datas) {
    projects.addAll(datas);
  }

  @action
  setSelectProject(ProjectData? data) {
    selectedProject = data;
  }

  @action
  replaceAllProject(Iterable<ProjectData> datas) {
    projects.removeWhere((e) => true);
    projects.addAll(datas);
    selectedProject = null;
  }

  @action
  bool updateProject(ProjectData data) {
    var itemIdx = projects.indexWhere((e) => data.id == e.id);
    if (itemIdx < 0) return false;
    projects[itemIdx] = data;
    return true;
  }
}
