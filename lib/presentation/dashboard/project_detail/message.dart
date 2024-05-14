import 'package:boilerplate/core/stores/misc/misc_store.dart';
import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';
import 'package:boilerplate/core/widgets/profile_icon_btn.dart';
import 'package:boilerplate/data/models/message_api_model.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/message_service.dart';
import 'package:boilerplate/presentation/message/interview_list.dart';
import 'package:boilerplate/presentation/message/widgets/history_item.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/constants/text.dart';

class ProjectMessageScreen extends StatefulWidget {
  final ProjectData projectData;
  const ProjectMessageScreen({super.key, required this.projectData});
  @override
  State<StatefulWidget> createState() {
    return _MessageScreenState();
  }
}

class _MessageScreenState extends State<ProjectMessageScreen> {
  final List<GetProjectMessageItem> messageHistories = [];
  final MessageService _messageService = getIt<MessageService>();

  void _getMyMessage() {
    _messageService.getMessageOfProject(
        projectId: widget.projectData.id,
        listener: (res, msgs) {
          if (msgs == null) return;
          setState(() {
            if (messageHistories.isNotEmpty) {
              messageHistories.removeRange(0, messageHistories.length);
            }
            messageHistories.addAll(msgs.messages);
          });
        });
  }

  @override
  void initState() {
    super.initState();
    _getMyMessage();
  }

  @override
  Widget build(BuildContext context) {
    var searchBox = TextFormField(
      style: TextStyle(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        icon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: Colors.blue),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );

    final msgScreen = RefreshIndicator(
      onRefresh: () async {
        _getMyMessage();
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(right: 16, top: 16),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: searchBox,
            ),
            SizedBox(height: 16),
            ...messageHistories.map(
              (e) => HistoryItem(
                history: e.messageHistory,
                projectId: widget.projectData.id,
              ),
            )
          ],
        ),
      ),
    );

    final interviewScreen = InterviewListScreen();

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: TabBarView(
            children: [msgScreen, interviewScreen],
          ),
        ),
      ),
    );
  }
}
