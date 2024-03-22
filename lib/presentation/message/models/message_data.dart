class MessageData {
  final String content =
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec qu.";
  final String sender;
  MessageData({required this.sender});
  DateTime timeStamp = DateTime.now();
}

class MessageHistory {
  static final List<MessageHistory> mockData = [
    MessageHistory(
      historyName: "Lam Hoang",
      initData: [
        MessageData(sender: "Lam Hoang"),
        MessageData(sender: "Lam Hoang"),
        MessageData(sender: "Luois Me"),
        MessageData(sender: "Lam Hoang"),
        MessageData(sender: "Luois Me"),
      ],
    ),
    MessageHistory(
      historyName: "Giang Thanh",
      initData: [
        MessageData(sender: "Giang Thanh"),
        MessageData(sender: "Luois Me"),
        MessageData(sender: "Luois Me"),
        MessageData(sender: "Giang Thanh"),
        MessageData(sender: "Luois Me"),
      ],
    ),
    MessageHistory(
      historyName: "Vu Toan",
      initData: [
        MessageData(sender: "Vu Toan"),
        MessageData(sender: "Vu Toan"),
        MessageData(sender: "Vu Toan"),
        MessageData(sender: "Luois Me"),
        MessageData(sender: "Luois Me"),
      ],
    ),
  ];

  final List<MessageData> histories = List.empty(growable: true);
  final String historyName;
  MessageHistory({required this.historyName, List<MessageData>? initData}) {
    if (initData != null) {
      histories.addAll(initData);
    }
  }
}
