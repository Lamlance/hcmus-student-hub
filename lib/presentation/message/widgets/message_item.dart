import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/data/models/message_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  static final DateFormat _dateFormat = DateFormat("HH:mm");
  static final DateFormat _interviewDateFormat = DateFormat("dd/MM/yyyy HH:mm");

  final Function(InterviewData data)? handleCancelMeeting;
  final Function(InterviewData data)? handleEditMeeting;

  final MessageData data;

  const MessageItem({
    super.key,
    required this.data,
    this.handleCancelMeeting,
    this.handleEditMeeting,
  });

  void _showInterviewEditDialog(InterviewData data, BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Edit ${data.title}',
              style: TextStyle(fontFamily: FontFamily.roboto),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (handleCancelMeeting != null) handleCancelMeeting!(data);
                  },
                  child: Text("Cancel meeting")),
              TextButton(
                  onPressed: () {
                    if (handleEditMeeting != null) handleEditMeeting!(data);
                  },
                  child: Text("Reschedule"))
            ],
          );
        });
  }

  Widget _makeInterviewMsg(InterviewData data, BuildContext ctx) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(data.title),
        Text('Start time: ${_interviewDateFormat.format(data.startTime)}'),
        Text('End time: ${_interviewDateFormat.format(data.endTime)}'),
        Row(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: data.disableFlag ? Colors.red : Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16 * 2),
              ),
              onPressed: data.disableFlag ? null : () {},
              child: Text(data.disableFlag ? "Canceled" : "Join",
                  style: TextStyle(color: Colors.black)),
            ),
            IconButton(
                onPressed: () {
                  _showInterviewEditDialog(data, ctx);
                },
                icon: Icon(Icons.more_horiz))
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: Icon(
              Icons.person,
              size: 48,
              color:
                  Color(data.sender.hashCode.abs() * 0xFFFFFF).withOpacity(1.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${data.sender} - ${_dateFormat.format(data.timeStamp)}'),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    child: data.interview != null
                        ? _makeInterviewMsg(data.interview!, context)
                        : Text(data.content),
                  ),
                )
              ],
            ),
          )
        ]),
        SizedBox(height: 16)
      ],
    );
  }
}
