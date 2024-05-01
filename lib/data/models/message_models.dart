class InterviewData {
  final int id;
  final int meetingId;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String roomCode;
  final String roomId;

  InterviewData({
    required this.id,
    required this.meetingId,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.roomCode,
    required this.roomId,
  });
  factory InterviewData.fromJson(Map<String, dynamic> json) {
    return InterviewData(
      id: json["id"],
      meetingId: json["meetingRoomId"],
      title: json["title"],
      startTime: DateTime.tryParse(json["startTime"]) ?? DateTime.now(),
      endTime: DateTime.tryParse(json["endTime"]) ?? DateTime.now(),
      roomCode: json["meetingRoom"]["meeting_room_code"],
      roomId: json["meetingRoom"]["meeting_room_id"],
    );
  }
}

class MessageData {
  final String content;
  final String sender;
  final int senderId;
  final int receiveId;
  final DateTime timeStamp;
  final String receive;
  final InterviewData? interview;
  MessageData({
    required this.sender,
    required this.senderId,
    required this.content,
    required this.timeStamp,
    required this.receiveId,
    required this.receive,
    this.interview,
  });

  factory MessageData.fromJson(Map<String, dynamic> e) {
    return MessageData(
      receive: e["receiver"]["fullname"],
      receiveId: e["receiver"]["id"],
      sender: e["sender"]["fullname"],
      senderId: e["sender"]["id"],
      content: e["content"],
      timeStamp: DateTime.tryParse(e["createdAt"]) ?? DateTime.now(),
      interview: e["interview"] == null
          ? null
          : InterviewData.fromJson(e["interview"]),
    );
  }
}

class MessageHistory {
  final List<MessageData> histories = List.empty(growable: true);
  final String historyName;
  MessageHistory({required this.historyName, List<MessageData>? initData}) {
    if (initData != null) {
      histories.addAll(initData);
    }
  }
  void addHistories(Iterable<MessageData> datas) {
    histories.addAll(datas);
  }
}
