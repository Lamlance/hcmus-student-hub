import 'package:boilerplate/presentation/message/widgets/create_meeting.dart';
import 'package:boilerplate/presentation/message/widgets/message_item.dart';
import 'package:flutter/material.dart';
import "dart:math" as math;
import 'package:boilerplate/data/models/message_models.dart';
import 'package:intl/intl.dart';

class MessageDetailScreen extends StatefulWidget {
  final MessageHistory history;
  const MessageDetailScreen({super.key, required this.history});

  @override
  State<StatefulWidget> createState() {
    return _MessageDetailScreenState();
  }
}

class _MessageDetailScreenState extends State<MessageDetailScreen> {
  static final _dateFormatOnlyDate = DateFormat("dd/MM/yyyy");

  Widget _buildMakeMeetingModal(BuildContext ctx) {
    return CreateMeetingModal();
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
                onPressed: () =>
                    _showModalBottomSheet(ctx, _buildMakeMeetingModal),
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
    var messageByDate = widget.history.histories
        .fold<Map<String, List<MessageData>>>({}, (previousValue, e) {
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
      previousValue.addAll(e.value.map((e) => MessageItem(data: e)));
      return previousValue;
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.history.historyName),
          actions: [
            IconButton(
                onPressed: () =>
                    _showModalBottomSheet(context, _buildBottomMenu),
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
                    Expanded(child: TextFormField()),
                    IconButton(onPressed: () {}, icon: Icon(Icons.send))
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
