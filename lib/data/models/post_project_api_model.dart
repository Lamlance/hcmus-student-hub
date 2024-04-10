class PostProjectApiModel {
  int companyId;
  int projectScopeFlag;
  String title;
  int numberOfStudents;
  String description;
  int typeFlag;
  List<String> tags;

  PostProjectApiModel({
    required this.companyId,
    required this.projectScopeFlag,
    required this.title,
    required this.numberOfStudents,
    required this.description,
    required this.typeFlag,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'numberOfStudents': numberOfStudents,
      'description': description,
      'typeFlag': typeFlag,
      'tags': tags,
    };
  }
}
