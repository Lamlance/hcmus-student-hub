import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:mobx/mobx.dart';
part 'dashboard_store.g.dart';

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
