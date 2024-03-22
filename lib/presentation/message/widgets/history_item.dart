import 'package:boilerplate/presentation/message/message_detail.dart';
import 'package:boilerplate/presentation/message/models/message_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatelessWidget {
  static final DateFormat _dateFormat = DateFormat("dd/MM/yyyy");
  final MessageHistory history;

  const HistoryItem({super.key, required this.history});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => MessageDetailScreen(history: history),
            ),
          ),
          child: Row(children: [
            Icon(Icons.person_pin, size: 64),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(history.historyName),
                        Text(history.histories.isNotEmpty
                            ? _dateFormat
                                .format(history.histories.last.timeStamp)
                            : ""),
                      ]),
                  SizedBox(height: 4),
                  Text(
                    history.histories.isNotEmpty
                        ? history.histories.last.content
                        : "",
                    maxLines: 2,
                  ),
                ],
              ),
            )
          ]),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Container(height: 2, color: Colors.grey),
        )
      ],
    );
  }
}
