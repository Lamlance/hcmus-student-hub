class CreateInterviewRequest {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final int projectId;
  final int senderId;
  final int receiverId;

  CreateInterviewRequest({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.projectId,
    required this.senderId,
    required this.receiverId,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime.toIso8601String(),
      "projectId": projectId,
      "senderId": senderId,
      "receiverId": receiverId
    };
  }
}
