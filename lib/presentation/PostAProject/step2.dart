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
  @override
  _S2PostAProjectState createState() => _S2PostAProjectState();
}

class _S2PostAProjectState extends State<S2PostAProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('StudentHub', style: TextStyle(fontSize: 20)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.profile);
            },
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
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
              children: ProjectDuration.values.map((ProjectDuration value) {
                return AppStyles.customRadioTile<ProjectDuration>(
                  value,
                  _projectDuration,
                  (ProjectDuration? value) {
                    setState(() {
                      _projectDuration = value!;
                    });
                  },
                  projectDurationToString(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'How many students do you want for this project?',
              style: AppStyles.titleStyle, // Use the title style
            ),
            SizedBox(height: 20),
            TextField(
              decoration: AppStyles.inputDecoration, // Use the input decoration
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => S3PostAProjectPage()),
                  );
                },
                child: Text('Next'),
                style: AppStyles.elevatedButtonStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
