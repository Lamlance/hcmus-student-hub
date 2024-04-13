import 'package:boilerplate/data/models/proposal_api_models.dart';

class ProjectListModel {
  final String title;
  final int monthTime;
  final int numberOfStudent;
  final String skill;
  final String quality;
  final String description;
  ProjectStatus projectStatus;

  ProjectListModel(
      {required this.title,
      this.monthTime = 3,
      this.numberOfStudent = 5,
      required this.skill,
      this.quality = "average",
      this.description =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ullamcorper est ligula, a hendrerit odio ullamcorper vel. Etiam tristique ligula ut imperdiet fringilla. Suspendisse potenti. Donec maximus eros sit amet lacinia mollis. Maecenas non tincidunt nisi. Nunc molestie velit sed tempus mattis. Duis vehicula, sem quis tincidunt maximus, leo lorem accumsan risus, sed volutpat orci purus vel mi. Nulla quis aliquet nisi",
      this.projectStatus = ProjectStatus.none});
}
