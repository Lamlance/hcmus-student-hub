class CreateProposalRequest {
  final int projectId;
  final int studentId;
  final String coverLetter;

  CreateProposalRequest(
      {required this.projectId,
      required this.studentId,
      required this.coverLetter});

  Map<String, dynamic> toJson() {
    return {
      "statusFlag": 1,
      "disableFlag": 0,
      "projectId": projectId,
      "studentId": studentId,
      "coverLetter": coverLetter,
    };
  }
}
