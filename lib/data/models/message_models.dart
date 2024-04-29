class MessageData {
  final String content;
  final String sender;
  final int senderId;
  final int receiveId;
  final DateTime timeStamp;
  final String receive;
  MessageData({
    required this.sender,
    required this.senderId,
    required this.content,
    required this.timeStamp,
    required this.receiveId,
    required this.receive,
  });

  factory MessageData.fromJson(Map<String, dynamic> e) {
    return MessageData(
      receive: e["receiver"]["fullname"],
      receiveId: e["receiver"]["id"],
      sender: e["sender"]["fullname"],
      senderId: e["sender"]["id"],
      content: e["content"],
      timeStamp: DateTime.tryParse(e["createdAt"]) ?? DateTime.now(),
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
