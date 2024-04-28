import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/post_project_service.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'step2.dart';
import 'bullet_widget.dart';
import 'styles.dart';

class S4PostAProjectPage extends StatefulWidget {
  final String projectName;
  final int numberOfStudent;
  final String projectDesc;
  final int projectDuration;

  const S4PostAProjectPage(
      {super.key,
      required this.projectName,
      required this.numberOfStudent,
      required this.projectDesc,
      required this.projectDuration});
  @override
  State<StatefulWidget> createState() => _S4PostAProjectState();
}

class _S4PostAProjectState extends State<S4PostAProjectPage> {
  final PostProjectService _projectService = getIt<PostProjectService>();
  final _userStore = getIt<UserStore>();

  void _handlePostJob() {
    final companyId = _userStore.selectedUser!.company?.id;
    if (companyId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Data'),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }

    _projectService.postProject(
      data: PostProjectApiModel(
        companyId: companyId,
        projectScopeFlag: switch (widget.projectDuration) {
          3 => 0,
          _ => 1,
        },
        title: widget.projectName,
        numberOfStudents: widget.numberOfStudent,
        description: widget.projectDesc,
      ),
      listener: (res) {
        Navigator.pushReplacementNamed(context, Routes.dashboard);
      },
    );
  }

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
            Flexible(
              child: Text(
                "4/4    Project details",
                style: AppStyles.titleStyle,
              ),
            ),
            SizedBox(height: 20),
            Text(widget.projectName, style: AppStyles.titleStyle),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(height: 2, color: Colors.grey),
            ),
            Text(widget.projectDesc, style: AppStyles.normalTextStyle),
            Container(
              height: 150,
              decoration: BoxDecoration(
                  //color: Constants.agreementBG,
                  borderRadius: BorderRadius.circular(14)),
            ),
            //Text(projectData.description, maxLines: 5),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(height: 2, color: Colors.grey),
            ),
            Row(children: [
              Icon(Icons.alarm, size: 38),
              SizedBox(width: 16),
              Text(
                'Project scope:\n About ${widget.projectDuration} months',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ]),
            SizedBox(height: 8),
            Row(children: [
              Icon(Icons.people_alt_outlined, size: 38),
              SizedBox(width: 16),
              Text(
                'Students required:\n ${widget.numberOfStudent} student',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ]),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _handlePostJob,
                child: Text('Post job'),
                style: AppStyles.elevatedButtonStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
