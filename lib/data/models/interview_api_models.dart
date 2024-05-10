import 'dart:convert';

class CreateInterviewRequest {
  static Codec<String, String> _stringToBase64 = utf8.fuse(base64);
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime expired_at;
  final int projectId;
  final int senderId;
  final int receiverId;
  final String meetingRoomCode;
  final String meetRoomId;

  CreateInterviewRequest({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.projectId,
    required this.senderId,
    required this.receiverId,
  })  : meetRoomId = DateTime.now().microsecondsSinceEpoch.toString(),
        meetingRoomCode = _stringToBase64.encode(
            '$title:$projectId:$senderId:$receiverId:$startTime:$endTime'),
        expired_at = endTime;

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime.toIso8601String(),
      "expired_at": expired_at.toIso8601String(),
      "projectId": projectId,
      "senderId": senderId,
      "receiverId": receiverId,
      "meeting_room_code": meetingRoomCode,
      "meeting_room_id": meetRoomId,
      "content": title
    };
  }
}
