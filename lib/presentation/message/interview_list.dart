import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/interview_service.dart';
import 'package:boilerplate/presentation/message/interview/interview_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/constants/text.dart';
import 'package:provider/provider.dart';

class InterviewListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InterviewListScreenState();
  }
}

class _InterviewListScreenState extends State<InterviewListScreen> {
  static final DateFormat _interviewDateFormat = DateFormat("dd/MM/yyyy HH:mm");

  final _interviewService = getIt<InterviewService>();
  final List<InterviewData> _interviews = [];

  void _getAllInterview() {
    _interviewService.getAllInterviews(listener: (res, data) {
      if (data == null) return;
      if (_interviews.isNotEmpty) {
        _interviews.removeRange(0, _interviews.length);
      }
      setState(() {
        _interviews.addAll(data);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllInterview();
  }

  Widget _buildInterviewItem(InterviewData data) {
    return Wrap(children: [
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => InterviewCallScreen(
                    interviewData: data,
                  ),
                ),
              );
            },
            child: Text(
              data.disableFlag
                  ? (Provider.of<LanguageProvider>(context).isEnglish
                      ? AppStrings.canceled_en
                      : AppStrings.canceled_vn)
                  : (Provider.of<LanguageProvider>(context).isEnglish
                      ? AppStrings.join_en
                      : AppStrings.join_vn),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [..._interviews.map((e) => _buildInterviewItem(e))],
        ),
      ),
    );
  }
}
