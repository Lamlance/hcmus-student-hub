class MessageData {
  final String content =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras iaculis lacinia dui non pretium. Cras cursus ultricies risus non finibus. Nulla quam lectus, accumsan at augue a, mollis varius orci. Maecenas semper auctor ex, eget vehicula sem volutpat ut. Suspendisse potenti. Etiam felis mi, ullamcorper vel leo at, bibendum posuere sapien. Pellentesque convallis, risus a feugiat cursus, ligula erat auctor lorem, euismod vehicula ipsum tortor quis sapien. Pellentesque ac dui sed metus pellentesque facilisis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Maecenas ac ullamcorper elit, porttitor rutrum metus.";
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
