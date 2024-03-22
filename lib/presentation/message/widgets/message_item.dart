import 'package:boilerplate/presentation/message/models/message_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageItem extends StatelessWidget {
  static final DateFormat _dateFormat = DateFormat("HH:mm");
  final MessageData data;

  const MessageItem({super.key, required this.data});
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
                    child: Text(data.content),
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
