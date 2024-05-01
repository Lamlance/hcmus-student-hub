import 'package:boilerplate/data/models/message_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  static final DateFormat _dateFormat = DateFormat("HH:mm");
  static final DateFormat _interviewDateFormat = DateFormat("dd/MM/yyyy HH:mm");

  final MessageData data;

  const MessageItem({super.key, required this.data});

  Widget _makeInterviewMsg(InterviewData data) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(data.title),
        Text('Start time: ${_interviewDateFormat.format(data.startTime)}'),
        Text('End time: ${_interviewDateFormat.format(data.endTime)}'),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16 * 2),
          ),
          onPressed: () {},
          child: Text("Join", style: TextStyle(color: Colors.black)),
        )
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
                        ? _makeInterviewMsg(data.interview!)
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
