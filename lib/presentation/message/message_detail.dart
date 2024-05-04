import 'dart:developer';

import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/interview_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/interview_service.dart';
import 'package:boilerplate/presentation/di/services/message_service.dart';
import 'package:boilerplate/presentation/di/services/socket_service.dart';
import 'package:boilerplate/presentation/message/widgets/create_meeting.dart';
import 'package:boilerplate/presentation/message/widgets/message_item.dart';
import 'package:flutter/material.dart';
import "dart:math" as math;
import 'package:boilerplate/data/models/message_models.dart';
import 'package:intl/intl.dart';

class MessageDetailScreen extends StatefulWidget {
  final MessageHistory history;
  final int projectId;
  const MessageDetailScreen(
      {super.key, required this.history, required this.projectId});

  @override
  State<StatefulWidget> createState() {
    return _MessageDetailScreenState();
  }
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  static final _dateFormatOnlyDate = DateFormat("dd/MM/yyyy");
  final _socketChatService = getIt<SocketChatService>();
  final _interviewService = getIt<InterviewService>();
  final _messageService = getIt<MessageService>();
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<MessageData> messages = [];
  final UserStore _userStore = getIt<UserStore>();
  late int targetId;
  late String targetName = "";

  void _handleMeetingModalSubmit({
    required String title,
    required DateTime startTime,
    required DateTime endTime,
    InterviewData? prevData,
  }) {
    if (prevData == null) {
      _socketChatService.sendInterview(CreateInterviewRequest(
        title: title,
        startTime: startTime,
        endTime: endTime,
        projectId: widget.projectId,
        senderId: _userStore.selectedUser!.userId,
        receiverId: targetId,
      ));
      return;
    }

    _interviewService.editInterview(
      interviewId: prevData.id,
      startTime: startTime,
      endTime: endTime,
      title: title,
      listener: (res) {
        log("Update interview: ${res.statusCode}");
      },
    );
  }

  void _handleSendMsg() {
    if (_msgController.text.isEmpty) return;
    _socketChatService.sendMsg(
      content: _msgController.text,
      receiveId: targetId,
      projectId: widget.projectId,
    );
    _msgController.clear();
  }

  void _connectToProject() {
    log("Connect to project ${widget.projectId}");
    _socketChatService.connectToProject(widget.projectId, (data) {
      log(data == null ? "Get null msg" : "Get msg");
      if (data == null) return;

      setState(() {
        messages.add(
          MessageData(
              receiveId: data.receiveId,
              receive: data.receiveId == _userStore.selectedUser!.userId
                  ? _userStore.selectedUser!.fullName
                  : targetName,
              sender: data.senderId == _userStore.selectedUser!.userId
                  ? _userStore.selectedUser!.fullName
                  : targetName,
              senderId: data.senderId,
              content: data.content,
              timeStamp: DateTime.now()),
        );
      });
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  void _handleCancelMeeting(InterviewData data) {
    _interviewService.cancelInterview(
        interviewId: data.id,
        listener: (res) {
          log('Cancel interview ${res.statusCode}');
        });
  }

  void _handleEditMeeting(InterviewData data) {
    _showModalBottomSheet(
      context,
      (ctx) => CreateMeetingModal(
        onSubmit: _handleMeetingModalSubmit,
        editData: data,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final first = widget.history.histories.first;
    if (first.senderId == first.receiveId) {
      targetId = first.receiveId;
    } else if (first.senderId == _userStore.selectedUser?.userId) {
      targetId = first.receiveId;
      targetName = first.receive;
    } else {
      targetId = first.senderId;
      targetName = first.sender;
    }
    log('$targetId & $targetName');
    _messageService.getMyMessageWith(
        projectId: widget.projectId,
        targetId: targetId,
        listener: (res, data) {
          if (data == null) return log("Missing data");
          setState(() {
            messages.addAll(data);
          });
        });
    _connectToProject();
  }

  Widget _buildBottomMenu(BuildContext ctx) {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: () => _showModalBottomSheet(
                  ctx,
                  (ctx) => CreateMeetingModal(
                    onSubmit: _handleMeetingModalSubmit,
                  ),
                ),
                child: Text("Schedule an interview"),
              )
            ],
          ),
        )
      ],
    );
  }

  void _showModalBottomSheet(
      BuildContext ctx, Widget Function(BuildContext ctx) builder) {
    showModalBottomSheet(
      context: ctx,
      builder: builder,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    var messageByDate =
        messages.fold<Map<String, List<MessageData>>>({}, (previousValue, e) {
      var key = _dateFormatOnlyDate.format(e.timeStamp);
      if (previousValue.containsKey(key) == false) {
        previousValue[key] = [e];
      } else {
        previousValue[key]!.add(e);
      }
      return previousValue;
    });
    var list = messageByDate.entries
        .fold<List<Widget>>(List.empty(growable: true), (previousValue, e) {
      previousValue.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(child: Container(height: 2, color: Colors.grey)),
            Text(e.key),
            Expanded(child: Container(height: 2, color: Colors.grey)),
          ],
        ),
      ));
      previousValue.addAll(
        e.value.map(
          (e) => MessageItem(
            data: e,
            handleCancelMeeting:
                e.interview == null ? null : _handleCancelMeeting,
            handleEditMeeting: e.interview == null ? null : _handleEditMeeting,
          ),
        ),
      );
      return previousValue;
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.history.historyName),
          actions: [
            IconButton(
                onPressed: () => _showModalBottomSheet(
                      context,
                      _buildBottomMenu,
                    ),
                icon: Icon(Icons.more_horiz))
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  (64 + 16 * 2 + 48 + MediaQuery.of(context).viewInsets.bottom),
              child: ListView(
                controller: _scrollController,
                children: [...list],
              ),
            ),
            Container(
              height: 64,
              decoration: BoxDecoration(color: Colors.blue.shade200),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: TextFormField(controller: _msgController)),
                    IconButton(
                      onPressed: _handleSendMsg,
                      icon: Icon(Icons.send),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
