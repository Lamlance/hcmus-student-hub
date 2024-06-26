enum SocketMsgFlag { none, interview }

class SocketMsgFlagUtils {
  static SocketMsgFlag intToMsgFlag(int flag) {
    return switch (flag) {
      0 => SocketMsgFlag.none,
      1 => SocketMsgFlag.interview,
      _ => SocketMsgFlag.none,
    };
  }

  static int socketMsgFlagToInt(SocketMsgFlag flag) {
    return switch (flag) {
      SocketMsgFlag.none => 0,
      SocketMsgFlag.interview => 1,
    };
  }
}

class SocketSendMessageRequest {
  final int projectId;
  final String content;
  final int senderId;
  final int receiveId;
  final SocketMsgFlag messageFlag;

  SocketSendMessageRequest(
      {required this.projectId,
      required this.content,
      required this.senderId,
      required this.receiveId,
      required this.messageFlag});

  Map<String, dynamic> toJson() {
    return {
      "projectId": projectId,
      "content": content,
      "messageFlag": SocketMsgFlagUtils.socketMsgFlagToInt(messageFlag),
      "senderId": senderId,
      "receiverId": receiveId
    };
  }
}

class SocketReceiveMessageEvent {
  final String content;
  final int senderId;
  final int receiveId;
  final SocketMsgFlag messageFlag;

  SocketReceiveMessageEvent(
      {required this.content,
      required this.senderId,
      required this.receiveId,
      required this.messageFlag});

  static SocketReceiveMessageEvent? tryFromJson(Map<String, dynamic> json) {
    final flags = ["content", "sender", "receiver", "message"];
    if (flags.firstWhere((e) => json[e] == null, orElse: () => "").isNotEmpty) {
      return null;
    }

    return SocketReceiveMessageEvent(
      content: json["message"]["content"],
      senderId: json["sender"]["id"],
      receiveId: json["receiver"]["id"],
      messageFlag:
          SocketMsgFlagUtils.intToMsgFlag(json["message"]["messageFlag"]),
    );
  }
}
