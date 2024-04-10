import 'package:boilerplate/presentation/profile/widgets/skills_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudentExperienceInputScreen extends StatefulWidget {
  final Function() onFinishInput;

  const StudentExperienceInputScreen({super.key, required this.onFinishInput});

  @override
  State<StatefulWidget> createState() {
    return _StudentExperienceInputScreenState();
  }
}

class _StudentExperienceInputScreenState
    extends State<StudentExperienceInputScreen> {
  List<SkillListDataModel> _experiences = [];
  static final DateFormat _dateFormat = DateFormat("MM-dd");
  @override
  Widget build(BuildContext context) {
    Widget experienceList = SkillList(
      args: SkillListArgs(
          title: "Experiences",
          titleOfName: "Project name",
          titleOfDesc: "Project description",
          titleOfDate1: "Start date",
          titleOfDate2: "End date",
          titleOfSkillSet: "Skill set"),
      data: _experiences,
      onSkillChange: (v) {
        _experiences.removeWhere((element) => true);
        setState(() {
          _experiences.addAll(v);
        });
      },
      renderItems: (v) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${v.name}",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.left,
          ),
          Text(
              style: TextStyle(fontSize: 12),
              "${_dateFormat.format(v.date1 ?? DateTime.now())} - ${_dateFormat.format(v.date2 ?? DateTime.now())}"),
          SizedBox(
            height: 8,
          ),
          Text(v.desc ?? "", style: TextStyle(fontSize: 16))
        ],
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Experience"),
          experienceList,
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              child: Text("Next"),
              onPressed: () {
                widget.onFinishInput();
              },
            ),
          )
        ],
      ),
    );
  }
}
