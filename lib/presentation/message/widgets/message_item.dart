import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/core/stores/misc/misc_store.dart';
import 'package:boilerplate/data/models/message_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/message/interview/interview_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/constants/text.dart';
import 'package:provider/provider.dart';

class MessageItem extends StatelessWidget {
  static final DateFormat _dateFormat = DateFormat("HH:mm");
  static final DateFormat _interviewDateFormat = DateFormat("dd/MM/yyyy HH:mm");

  final Function(InterviewData data)? handleCancelMeeting;
  final Function(InterviewData data)? handleEditMeeting;

  final MessageData data;
  final _miscStore = getIt<MiscStore>();

  MessageItem({
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
                child: Text(
                  _miscStore.isEnglish
                      ? AppStrings.cancelMeeting_en
                      : AppStrings.cancelMeeting_vn,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (handleEditMeeting != null) handleEditMeeting!(data);
                },
                child: Text(
                  _miscStore.isEnglish
                      ? AppStrings.reschedule_en
                      : AppStrings.reschedule_vn,
                ),
              )
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
              onPressed: () {
                Navigator.of(ctx).push(
                  MaterialPageRoute(
                    builder: (context) => InterviewCallScreen(
                      interviewData: data,
                    ),
                  ),
                );
              },
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
