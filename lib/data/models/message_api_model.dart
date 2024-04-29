import 'package:boilerplate/data/models/message_models.dart';
import 'package:boilerplate/data/models/project_models.dart';
export "package:boilerplate/data/models/message_models.dart";
export 'package:boilerplate/data/models/project_models.dart';

class GetMyMessageItem {
  final ProjectData projectData;
  final MessageHistory messageHistory;
  GetMyMessageItem({required this.projectData, required this.messageHistory});

  static List<GetMyMessageItem> manyFromJson(Map<String, dynamic> json) {
    final project = ProjectData.fromJson(json["project"]);
    final msgs = (json["messages"] ?? []) as List<dynamic>;

    final msgBySender = msgs.fold({}, (prev, e) {
      final data = MessageData.fromJson(e);
      final keyArr = [
        e["sender"]["id"].toString(),
        e["receiver"]["id"].toString()
      ];
      keyArr.sort();
      final key = keyArr.join("_");
      if (prev.containsKey(key) == false) {
        prev[key] = [data];
      } else {
        prev[key]!.add(data);
      }
      return prev;
    });
    return msgBySender.entries
        .map(
          (e) => GetMyMessageItem(
            projectData: project,
            messageHistory: MessageHistory(
              historyName: json["project"]["title"],
              initData: e.value,
            ),
          ),
        )
        .toList();
  }

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
