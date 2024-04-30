import 'package:boilerplate/core/widgets/profile_icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'step3.dart';
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
  const S2PostAProjectPage({super.key, required this.projectName});

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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => S3PostAProjectPage(
          projectDuration: switch (_projectDuration) {
            ProjectDuration.shortTerm => 3,
            ProjectDuration.longTerm => 6
          },
          projectName: widget.projectName,
          numberOfStudent: int.parse(_numberOfStudentController.text),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('StudentHub'),
        actions: <Widget>[ProfileIconButton()],
      ),
      body: SingleChildScrollView(
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
                decoration:
                    AppStyles.inputDecoration, // Use the input decoration
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _handleNextPageClick,
                child: Text('Next: Descripption'),
                style: AppStyles.elevatedButtonStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
            )
          ],
        ),
      ),
    );
  }
}
