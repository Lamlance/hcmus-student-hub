import 'package:mobx/mobx.dart';
//part 'project_store.g.dart';

class BrowseProjectData {
  final int id;
  final String title;
  final int monthTime;
  final int numberOfStudent;
  final String description;
  late DateTime createdDate;
  BrowseProjectData(
      {required this.id,
      this.title = "title",
      this.monthTime = 3,
      this.numberOfStudent = 5,
      this.description = "description",
      DateTime? createdDate}) {
    this.createdDate = createdDate ?? DateTime.now();
  }
}

abstract class _BrowseProjectStore with Store {
  @observable
  BrowseProjectData? selectedProject;

  @observable
  List<BrowseProjectData> projects = [
    BrowseProjectData(
        id: 1,
        title: "Senior frontend developer (Fintech)",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ullamcorper est ligula, a hendrerit odio ullamcorper vel. Etiam tristique ligula ut imperdiet fringilla. Suspendisse potenti. Donec maximus eros sit amet lacinia mollis. Maecenas non tincidunt nisi. Nunc molestie velit sed tempus mattis. Duis vehicula, sem quis tincidunt maximus, leo lorem accumsan risus, sed volutpat orci purus vel mi. Nulla quis aliquet nisi. "),
    BrowseProjectData(
        id: 2,
        title: "Senior backend",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ullamcorper est ligula, a hendrerit odio ullamcorper vel. Etiam tristique ligula ut imperdiet fringilla. Suspendisse potenti. Donec maximus eros sit amet lacinia mollis. Maecenas non tincidunt nisi. Nunc molestie velit sed tempus mattis. Duis vehicula, sem quis tincidunt maximus, leo lorem accumsan risus, sed volutpat orci purus vel mi. Nulla quis aliquet nisi. "),
    BrowseProjectData(
        id: 3,
        title: "Junior level frontend",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ullamcorper est ligula, a hendrerit odio ullamcorper vel. Etiam tristique ligula ut imperdiet fringilla. Suspendisse potenti. Donec maximus eros sit amet lacinia mollis. Maecenas non tincidunt nisi. Nunc molestie velit sed tempus mattis. Duis vehicula, sem quis tincidunt maximus, leo lorem accumsan risus, sed volutpat orci purus vel mi. Nulla quis aliquet nisi. "),
    BrowseProjectData(
        id: 4,
        title: "Senior backend",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ullamcorper est ligula, a hendrerit odio ullamcorper vel. Etiam tristique ligula ut imperdiet fringilla. Suspendisse potenti. Donec maximus eros sit amet lacinia mollis. Maecenas non tincidunt nisi. Nunc molestie velit sed tempus mattis. Duis vehicula, sem quis tincidunt maximus, leo lorem accumsan risus, sed volutpat orci purus vel mi. Nulla quis aliquet nisi. "),
  ];

  @action
  setSelectProject(BrowseProjectData? data) {
    selectedProject = data;
  }
}
