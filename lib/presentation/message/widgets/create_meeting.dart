import 'dart:developer';

import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/interview_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateMeetingModal extends StatefulWidget {
  final int projectId;
  final int senderId;
  final int receiverId;

  const CreateMeetingModal(
      {super.key,
      required this.projectId,
      required this.senderId,
      required this.receiverId});
  @override
  State<StatefulWidget> createState() {
    return _CreateMeetingModalState();
  }
}

class _CreateMeetingModalState extends State<CreateMeetingModal> {
  static final DateFormat _dateFormat = DateFormat("dd/MM/yyyy HH:mm");
  final _interviewService = getIt<InterviewService>();
  final _titleController = TextEditingController();
  DateTime? startTime;
  DateTime? endTime;

  void _handleSubmitInterview() {
    if (startTime == null || endTime == null || _titleController.text.isEmpty) {
      return;
    }

    _interviewService.createInterview(
      data: CreateInterviewRequest(
        title: _titleController.text,
        startTime: startTime!,
        endTime: endTime!,
        projectId: widget.projectId,
        senderId: widget.senderId,
        receiverId: widget.receiverId,
      ),
      listener: (res) {
        log("Create interview ${res.data}");
      },
    );
  }

  Future<DateTime?> _showDatePicker(BuildContext ctx) async {
    var date = await showDatePicker(
      context: ctx,
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(
        Duration(days: 31 * 12),
      ),
    );
    if (date == null) return null;

    var time = await showTimePicker(context: ctx, initialTime: TimeOfDay.now());
    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context) {
    var startTimeTxt = startTime == null
        ? "Select start time"
        : _dateFormat.format(startTime!);
    var endTimeTxt =
        endTime == null ? "Select end time" : _dateFormat.format(endTime!);
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text("Start time"),
              Row(children: [
                Text(startTimeTxt, style: TextStyle(fontSize: 18)),
                IconButton(
                    onPressed: () async {
                      var dateTime = await _showDatePicker(context);
                      if (dateTime != null) {
                        setState(() {
                          startTime = dateTime;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_month, size: 32))
              ]),
              SizedBox(height: 16),
              Text("End time"),
              Row(children: [
                Text(endTimeTxt, style: TextStyle(fontSize: 18)),
                IconButton(
                    onPressed: () async {
                      var dateTime = await _showDatePicker(context);
                      if (dateTime != null) {
                        setState(() {
                          endTime = dateTime;
                        });
                      }
                    },
                    icon: Icon(Icons.calendar_month, size: 32))
              ]),
              SizedBox(height: 16),
              TextButton(
                  onPressed: _handleSubmitInterview, child: Text("Submit")),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              )
            ],
          ),
        )
      ],
    );
  }
}
