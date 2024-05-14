import 'package:boilerplate/core/stores/misc/misc_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/interview_service.dart';
import 'package:boilerplate/presentation/message/interview/interview_call_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:boilerplate/constants/text.dart';

class InterviewListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InterviewListScreenState();
  }
}

class _InterviewListScreenState extends State<InterviewListScreen> {
  static final DateFormat _interviewDateFormat = DateFormat("dd/MM/yyyy HH:mm");
  final _miscStore = getIt<MiscStore>();

  final _interviewService = getIt<InterviewService>();
  final List<InterviewData> _interviews = [];

  void _handleInterviewClick(InterviewData data) {
    _interviewService.getDetailInterview(
        interviewId: data.id,
        listener: (res, interview) {
          if (interview == null) return;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InterviewCallScreen(
                interviewData: interview,
              ),
            ),
          );
        });
  }

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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            data.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Start time: ${_interviewDateFormat.format(data.startTime)}',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'End time: ${_interviewDateFormat.format(data.endTime)}',
            style: TextStyle(fontSize: 18),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: data.disableFlag ? Colors.red : Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 16 * 2),
            ),
            onPressed: () {
              if (data.disableFlag) {
                return;
              }

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
                  ? (_miscStore.isEnglish
                      ? AppStrings.canceled_en
                      : AppStrings.canceled_vn)
                  : (_miscStore.isEnglish
                      ? AppStrings.join_en
                      : AppStrings.join_vn),
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(color: Colors.black)
        ],
      ),
    );
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
