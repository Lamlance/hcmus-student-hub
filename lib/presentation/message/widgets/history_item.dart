import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/message/message_detail.dart';
import 'package:boilerplate/data/models/message_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatelessWidget {
  static final DateFormat _dateFormat = DateFormat("dd/MM/yyyy");
  final _userStore = getIt<UserStore>();
  final MessageHistory history;
  final int projectId;
  HistoryItem({super.key, required this.history, required this.projectId});
  @override
  Widget build(BuildContext context) {
    final lastMsg =
        history.histories.isNotEmpty ? history.histories.last : null;
    final targetName = lastMsg == null
        ? ""
        : (lastMsg.senderId == _userStore.selectedUser!.userId
            ? lastMsg.receive
            : lastMsg.sender);

    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => MessageDetailScreen(
                history: history,
                projectId: projectId,
              ),
            ),
          ),
          child: Row(children: [
            Icon(Icons.person_pin, size: 64),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${history.historyName}\n-$targetName',
                            maxLines: 2),
                        Text(lastMsg != null
                            ? _dateFormat.format(lastMsg.timeStamp)
                            : ""),
                      ]),
                  SizedBox(height: 4),
                  Text(
                    lastMsg != null ? lastMsg.content : "",
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold),
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
