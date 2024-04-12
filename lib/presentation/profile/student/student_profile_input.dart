import 'package:boilerplate/data/models/misc_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/misc_service.dart';
import 'package:boilerplate/presentation/profile/student/student_experience_input.dart';
import 'package:boilerplate/presentation/profile/widgets/skill_set.dart';
import 'package:boilerplate/presentation/profile/widgets/skills_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StudentProfileInputScreen extends StatefulWidget {
  final Function(TechStackData tech, List<SkillSetData> skillSets)
      onFinishInput;

  const StudentProfileInputScreen({super.key, required this.onFinishInput});

  @override
  State<StatefulWidget> createState() {
    return _StudentProfileInputScreenState();
  }
}

class _StudentProfileInputScreenState extends State<StudentProfileInputScreen> {
  static final DateFormat _dateFormat = DateFormat("yyyy-MM-dd");
  final MiscService _miscService = getIt<MiscService>();
  final _formKey = GlobalKey<FormState>();

  final List<TechStackData> _techList = List.empty(growable: true);
  TechStackData? _selectedTech;
  final List<SkillSetData> _skillSetList = [];
  final List<SkillListDataModel> _languageSkills = [];
  final List<SkillListDataModel> _academicSkills = [];

  @override
  void initState() {
    super.initState();
    if (_techList.isEmpty) {
      _miscService.getAllTechStack(listener: (res, data) {
        if (data != null) {
          setState(() {
            _techList.addAll(data.response);
          });
        }
      });
    }
  }

  _onNextBtnPress() {
    if (_selectedTech == null ||
        (_formKey.currentState?.validate() ?? false) == false) {
      return;
    }
    widget.onFinishInput(_selectedTech!, _skillSetList);
  }

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

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
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
            DropdownButtonFormField<TechStackData>(
                validator: (v) =>
                    v == null ? "Need to select a tech stack" : null,
                isExpanded: true,
                onChanged: (v) {
                  if (v == null) return;
                  setState(() {
                    _selectedTech = v;
                  });
                },
                value: _selectedTech,
                items: _techList
                    .map((e) => DropdownMenuItem<TechStackData>(
                          child: Text(e.name),
                          value: e,
                        ))
                    .toList()),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Skill sets"),
            ),
            SkillSet(
              onSkillSetsSelect: (skills) {
                _skillSetList.removeWhere((e) => true);
                _skillSetList.addAll(skills);
              },
            ),
            SizedBox(height: 16),
            languageSkillList,
            SizedBox(height: 16),
            academicSkillList,
            SizedBox(height: 24),
            Align(
              child: TextButton(
                  onPressed: _onNextBtnPress, child: const Text("Next")),
              alignment: Alignment.centerRight,
            )
          ],
        ),
      ),
    );
  }
}
