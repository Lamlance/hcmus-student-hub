import 'package:flutter/material.dart';

import 'styles.dart';

enum ProjectDuration { shortTerm, longTerm }

ProjectDuration _projectDuration = ProjectDuration.shortTerm;

String projectDurationToString(ProjectDuration duration) {
  switch (duration) {
    case ProjectDuration.shortTerm:
      return '1 to 3 months';
    case ProjectDuration.longTerm:
      return '3 to 6 months';
    default:
      return '';
  }
}

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
            "2/4    Next, estimate the scope of your job",
            style: AppStyles.titleStyle,
          ),
          SizedBox(height: 30),
          Text("Consider the size of your project and the timeline",
              style: AppStyles.normalTextStyle),
          SizedBox(height: 30),
          Text(
            'How long will your project take?',
            style: AppStyles.titleStyle, // Use the title style
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
            'How many students do you want for this project?',
            style: AppStyles.titleStyle, // Use the title style
          ),
          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) {
                if (value == null || int.tryParse(value) == null) {
                  return "Please insert valid number";
                }
                return value.isEmpty ? "Please insert a number" : null;
              },
              controller: _numberOfStudentController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Number of student",
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
              child: Text('Next: Description'),
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
