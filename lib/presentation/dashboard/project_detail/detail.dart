import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:flutter/material.dart';

class ProjectDetailInfoScreen extends StatelessWidget {
  final ProjectData projectData;

  const ProjectDetailInfoScreen({super.key, required this.projectData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text(
            "Project title",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Text(projectData.title),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(height: 2, color: Colors.grey),
          ),
          Text(
            "Project description",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 8),
          Text(projectData.description, maxLines: 5),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(height: 2, color: Colors.grey),
          ),
          Row(children: [
            Icon(Icons.alarm, size: 38),
            SizedBox(width: 16),
            Text(
              'Project scope:\n${projectData.monthTime} month(s)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ]),
          SizedBox(height: 8),
          Row(children: [
            Icon(Icons.people_alt_outlined, size: 38),
            SizedBox(width: 16),
            Text(
              'Students required:\n${projectData.numberOfStudent} student(s)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ]),
        ],
      ),
    );
  }
}
