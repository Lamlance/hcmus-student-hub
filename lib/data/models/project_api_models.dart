class PostProjectApiModel {
  final int companyId;
  final int projectScopeFlag;
  final String title;
  final int numberOfStudents;
  final String description;
  PostProjectApiModel({
    required this.companyId,
    required this.projectScopeFlag,
    required this.title,
    required this.numberOfStudents,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'companyId': companyId,
      'projectScopeFlag': projectScopeFlag,
      'title': title,
      'numberOfStudents': numberOfStudents,
      'description': description,
    };
  }
}
