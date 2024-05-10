import 'package:boilerplate/core/stores/misc/misc_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/constants/text.dart';
import 'package:provider/provider.dart';

import 'styles.dart';

enum ProjectDuration { shortTerm, longTerm }

ProjectDuration _projectDuration = ProjectDuration.shortTerm;

class S2PostAProjectPage extends StatefulWidget {
  final String projectName;
  final int numberOfStudent;
  final int projectDuration;
  final void Function(int duration, int numOfStudent) onSubmit;

  const S2PostAProjectPage({
    super.key,
    required this.projectName,
    this.projectDuration = 3,
    this.numberOfStudent = 0,
    required this.onSubmit,
  });

  @override
  State<StatefulWidget> createState() {
    return _S2PostAProjectState();
  }
}

class _S2PostAProjectState extends State<S2PostAProjectPage> {
  final _numberOfStudentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ProjectDuration _projectDuration = ProjectDuration.shortTerm;
  final _miscStore = getIt<MiscStore>();
  String projectDurationToString(ProjectDuration duration) {
    switch (duration) {
      case ProjectDuration.shortTerm:
        return _miscStore.isEnglish
            ? AppStrings.oneToThreeMonth_en
            : AppStrings.oneToThreeMonth_vn;
      case ProjectDuration.longTerm:
        return _miscStore.isEnglish
            ? AppStrings.threeToSixMonth_en
            : AppStrings.threeToSixMonth_vn;
      default:
        return '';
    }
  }

  void _handleProjectDurationChange(ProjectDuration? value) {
    if (value == null) return;
    setState(() {
      _projectDuration = value;
    });
  }

  void _handleNextPageClick() {
    if (_formKey.currentState!.validate() == false) return;
    widget.onSubmit(
        switch (_projectDuration) {
          ProjectDuration.shortTerm => 3,
          ProjectDuration.longTerm => 6
        },
        int.parse(_numberOfStudentController.text));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _numberOfStudentController.text = widget.numberOfStudent.toString();
      _projectDuration = switch (widget.projectDuration) {
        3 => ProjectDuration.shortTerm,
        _ => ProjectDuration.longTerm
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _miscStore.isEnglish
                ? AppStrings.step2Title_en
                : AppStrings.step2Title_vn,
            style: AppStyles.titleStyle,
          ),
          SizedBox(height: 30),
          Text(
            _miscStore.isEnglish
                ? AppStrings.step2Desc_en
                : AppStrings.step2Desc_vn,
            style: AppStyles.normalTextStyle,
          ),
          SizedBox(height: 30),
          Text(
            _miscStore.isEnglish
                ? AppStrings.projDuration_en
                : AppStrings.projDuration_vn,
            style: AppStyles.titleStyle,
          ),
          Column(
            children: ProjectDuration.values.map((ProjectDuration duration) {
              return RadioListTile<ProjectDuration>(
                title: Text(projectDurationToString(duration)),
                value: duration,
                groupValue: _projectDuration,
                onChanged: _handleProjectDurationChange,
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Text(
            _miscStore.isEnglish
                ? AppStrings.studentNum_en
                : AppStrings.studentNum_vn,
            style: AppStyles.titleStyle,
          ),
          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) {
                if (value == null || int.tryParse(value) == null) {
                  return _miscStore.isEnglish
                      ? AppStrings.validNumber_en
                      : AppStrings.validNumber_vn;
                }
                return value.isEmpty
                    ? _miscStore.isEnglish
                        ? AppStrings.insertNumber_en
                        : AppStrings.insertNumber_vn
                    : null;
              },
              controller: _numberOfStudentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: _miscStore.isEnglish
                    ? AppStrings.numberOfStudent_en
                    : AppStrings.numberOfStudent_vn,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ), // Use the input decoration
            ),
          ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _handleNextPageClick,
              child: Text(
                _miscStore.isEnglish
                    ? AppStrings.nextEstimate_en
                    : AppStrings.nextEstimate_vn,
                style: AppStyles.titleStyle,
              ),
              style: AppStyles.elevatedButtonStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
          )
        ],
      ),
    );
  }
}
