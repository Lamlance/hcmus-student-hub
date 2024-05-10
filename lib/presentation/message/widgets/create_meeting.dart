import 'package:boilerplate/core/stores/misc/misc_store.dart';
import 'package:boilerplate/data/models/message_api_model.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:boilerplate/constants/text.dart';

typedef MeetingModalOnSumbit = Function({
  required String title,
  required DateTime startTime,
  required DateTime endTime,
  InterviewData? prevData,
});

class CreateMeetingModal extends StatefulWidget {
  final MeetingModalOnSumbit onSubmit;

  final InterviewData? editData;

  const CreateMeetingModal({
    super.key,
    required this.onSubmit,
    this.editData,
  });
  @override
  State<StatefulWidget> createState() {
    return _CreateMeetingModalState();
  }
}

class _CreateMeetingModalState extends State<CreateMeetingModal> {
  static final DateFormat _dateFormat = DateFormat("dd/MM/yyyy HH:mm");
  final _titleController = TextEditingController();
  final _miscStore = getIt<MiscStore>();

  DateTime? startTime;
  DateTime? endTime;

  void _handleSubmitInterview() {
    if (startTime == null || endTime == null || _titleController.text.isEmpty) {
      return;
    }
    widget.onSubmit(
      title: _titleController.text,
      startTime: startTime!,
      endTime: endTime!,
      prevData: widget.editData,
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
  void initState() {
    super.initState();
    if (widget.editData != null) {
      setState(() {
        startTime = widget.editData!.startTime;
        endTime = widget.editData!.endTime;
        _titleController.text = widget.editData!.title;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var startTimeTxt = startTime == null
        ? (_miscStore.isEnglish
            ? AppStrings.selectStartTime_en
            : AppStrings.selectStartTime_vn)
        : _dateFormat.format(startTime!);
    var endTimeTxt = endTime == null
        ? (_miscStore.isEnglish
            ? AppStrings.selectEndTime_en
            : AppStrings.selectEndTime_vn)
        : _dateFormat.format(endTime!);
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
                  labelText: _miscStore.isEnglish
                      ? AppStrings.title_en
                      : AppStrings.title_vn,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Text(
                _miscStore.isEnglish
                    ? AppStrings.startTime_en
                    : AppStrings.startTime_vn,
              ),
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
              Text(
                _miscStore.isEnglish
                    ? AppStrings.endTime_en
                    : AppStrings.endTime_vn,
              ),
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
