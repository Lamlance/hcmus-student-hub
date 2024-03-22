import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';

class HireModel {
  final String name;
  final int nthYear;
  final String skill;
  final String quality;
  final String desc;
  HireStatus hireStatus;
  HireModel(
      {required this.name,
      this.nthYear = 1,
      required this.skill,
      this.quality = "average",
      this.desc =
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ullamcorper est ligula, a hendrerit odio ullamcorper vel. Etiam tristique ligula ut imperdiet fringilla. Suspendisse potenti. Donec maximus eros sit amet lacinia mollis. Maecenas non tincidunt nisi. Nunc molestie velit sed tempus mattis. Duis vehicula, sem quis tincidunt maximus, leo lorem accumsan risus, sed volutpat orci purus vel mi. Nulla quis aliquet nisi",
      this.hireStatus = HireStatus.propose});
}
