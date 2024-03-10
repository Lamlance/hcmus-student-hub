import 'dart:developer';

import 'package:boilerplate/presentation/profile/student/student_experience_input.dart';
import 'package:boilerplate/presentation/profile/widgets/skill_set.dart';
import 'package:boilerplate/presentation/profile/widgets/skills_list.dart';
import 'package:boilerplate/presentation/profile/widgets/skillset_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudentProfileInputScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentProfileInputScreenState();
  }
}

class _StudentProfileInputScreenState extends State<StudentProfileInputScreen> {
  static const List<String> _techPositions = [
    "Fullstack engineer",
    "Front-end engineer",
    "Back-end engineer",
    "Data engineer",
  ];
  static final DateFormat _dateFormat = DateFormat("yyyy-MM-dd");
  String _selectTechPosition = _techPositions.first;

  List<SkillListDataModel> _languageSkills = [];
  List<SkillListDataModel> _academicSkills = [];

  @override
  Widget build(BuildContext context) {
    Widget languageSkillList = SkillList(
        data: _languageSkills,
        onSkillChange: (v) {
          _languageSkills.removeWhere((element) => true);
          setState(() {
            _languageSkills.addAll(v);
          });
        },
        renderItems: (v) => Text("${v.name}: ${v.desc}"),
        args: SkillListArgs(
            title: "Language skill",
            titleOfName: "Language name",
            titleOfDesc: "Level"));

    Widget academicSkillList = SkillList(
        data: _academicSkills,
        onSkillChange: (v) {
          _academicSkills.removeWhere((element) => true);
          setState(() {
            _academicSkills.addAll(v);
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
                    "${_dateFormat.format(v.date1 ?? DateTime.now())} - ${_dateFormat.format(v.date2 ?? DateTime.now())}")
              ],
            ),
        args: SkillListArgs(
            title: "Academic level",
            titleOfName: "School name",
            titleOfDate1: "Start date",
            titleOfDate2: "End date"));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student hub"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Text("Welcome to student hub"),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                    "Tell us about yourself and you will be on your way to connect with real-world projects")),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Techstack"),
            ),
            DropdownButton<String>(
                isExpanded: true,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() {
                    _selectTechPosition = v;
                  });
                },
                value: _selectTechPosition,
                items: _techPositions
                    .map((e) => DropdownMenuItem<String>(
                          child: Text(e),
                          value: e,
                        ))
                    .toList()),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Skill sets"),
            ),
            SkillSet(),
            SizedBox(height: 16),
            languageSkillList,
            SizedBox(height: 16),
            academicSkillList,
            SizedBox(height: 24),
            Align(
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => SafeArea(
                                child: StudentExperienceInputScreen())));
                  },
                  child: const Text("Next")),
              alignment: Alignment.centerRight,
            )
          ],
        ),
      ),
    );
  }
}
