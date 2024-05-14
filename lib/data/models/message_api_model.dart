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
        initData: [MessageData.fromJson(json)],
      ),
    );
  }
}

class GetMyMessageRespond {
  final List<GetMyMessageItem> messages;
  GetMyMessageRespond({required this.messages});
  factory GetMyMessageRespond.fromJson(Map<String, dynamic> json) {
    final List<GetMyMessageItem> msgs = [];
    return GetMyMessageRespond(
      messages: ((json["result"] ?? []) as List<dynamic>).fold(
        msgs,
        (prev, e) {
          prev.add(GetMyMessageItem.fromJson(e));
          return prev;
        },
      ),
    );
  }
}

class GetProjectMessageItem {
  final MessageHistory messageHistory;

  GetProjectMessageItem({required this.messageHistory});
  factory GetProjectMessageItem.fromJson(Map<String, dynamic> json) {
    return GetProjectMessageItem(
      messageHistory: MessageHistory(
        historyName: "",
        initData: [MessageData.fromJson(json)],
      ),
    );
  }
}

class GetProjectMessageRespond {
  final List<GetProjectMessageItem> messages;
  GetProjectMessageRespond({required this.messages});
  factory GetProjectMessageRespond.fromJson(Map<String, dynamic> json) {
    final List<GetProjectMessageItem> msgs = [];
    return GetProjectMessageRespond(
      messages: ((json["result"] ?? []) as List<dynamic>).fold(
        msgs,
        (prev, e) {
          prev.add(GetProjectMessageItem.fromJson(e));
          return prev;
        },
      ),
    );
  }
}
