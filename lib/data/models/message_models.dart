class MessageData {
  final String content;
  final String sender;
  final int senderId;
  final DateTime timeStamp;
  MessageData(
      {required this.sender,
      required this.senderId,
      required this.content,
      required this.timeStamp});
}

class MessageHistory {
  final List<MessageData> histories = List.empty(growable: true);
  final String historyName;
  MessageHistory({required this.historyName, List<MessageData>? initData}) {
    if (initData != null) {
      histories.addAll(initData);
    }
  }
}
