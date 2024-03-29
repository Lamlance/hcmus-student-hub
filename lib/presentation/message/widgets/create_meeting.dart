import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateMeetingModal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateMeetingModalState();
  }
}

class _CreateMeetingModalState extends State<CreateMeetingModal> {
  static final DateFormat _dateFormat = DateFormat("dd/MM/yyyy HH:mm");
  DateTime? startTime;
  DateTime? endTime;

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
                decoration: InputDecoration(
                    labelText: "Title", border: OutlineInputBorder()),
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
              TextButton(onPressed: () {}, child: Text("Submit")),
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
