import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/message_service.dart';
import 'package:boilerplate/presentation/message/widgets/history_item.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/data/models/message_models.dart';

class MessageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MessageScreenState();
  }
}

class _MessageScreenState extends State<MessageScreen> {
  final List<MessageHistory> messageHistories = [];
  final MessageService _messageService = getIt<MessageService>();

  void _getMyMessage() {
    _messageService.getMyMessage(listener: (res, msgs) {
      if (msgs == null) return;
      setState(() {
        if (messageHistories.isNotEmpty) {
          messageHistories.removeRange(0, messageHistories.length);
        }
        messageHistories.addAll(msgs.messages.map((e) => e.messageHistory));
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Student hub - message"),
        ),
        bottomNavigationBar: MainBottomNavBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            _getMyMessage();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: searchBox,
                ),
                SizedBox(height: 16),
                ...messageHistories.map((e) => HistoryItem(history: e))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
