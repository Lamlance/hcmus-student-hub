import 'package:boilerplate/data/models/message_models.dart';
import 'package:boilerplate/data/models/project_models.dart';
export "package:boilerplate/data/models/message_models.dart";
export 'package:boilerplate/data/models/project_models.dart';

class GetMyMessageItem {
  final ProjectData projectData;
  final MessageHistory messageHistory;
  GetMyMessageItem({required this.projectData, required this.messageHistory});
  factory GetMyMessageItem.fromJson(Map<String, dynamic> json) {
    return GetMyMessageItem(
      projectData: ProjectData.fromJson(json["project"]),
      messageHistory: MessageHistory(
          historyName: json["project"]["title"],
          initData: (json["messages"] as List<dynamic>)
              .map(
                (e) => MessageData(
                  sender: e["sender"]["fullname"],
                  senderId: e["sender"]["id"],
                  content: e["content"],
                  timeStamp:
                      DateTime.tryParse(e["createdAt"]) ?? DateTime.now(),
                ),
              )
              .toList()),
    );
  }
}

class GetMyMessageRespond {
  final List<GetMyMessageItem> messages;
  GetMyMessageRespond({required this.messages});
  factory GetMyMessageRespond.fromJson(Map<String, dynamic> json) {
    return GetMyMessageRespond(
      messages: (json["result"] as List<dynamic>)
          .map((e) => GetMyMessageItem.fromJson(e))
          .toList(),
    );
  }
}
