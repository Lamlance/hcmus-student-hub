import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/BrowseAllProject/apply_project.dart';
import 'package:boilerplate/presentation/dashboard/project_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectItemTab extends StatelessWidget {
  static final DateFormat _dateFormat = DateFormat("dd-MM-yyyy");
  final ProjectData projectData;
  final Function(ProjectData data)? onOptionClick;

  ProjectItemTab({
    super.key,
    required this.projectData,
    this.onOptionClick,
  });

  void _onIemClick(BuildContext context) {
    // if (displayNumber == false) return;
    // _dashBoardStore.setSelectProject(projectData);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => SafeArea(
          child: ApplyProjectScreen(data: projectData),
        ),
      ),
    );
  }

  void _onOptionsClick() {
    if (onOptionClick != null) {
      onOptionClick!(projectData);
    }
    // _dashBoardStore.setSelectProject(projectData);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => _onIemClick(context),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                projectData.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border))
            ],
          ),
          Text("Created ${_dateFormat.format(projectData.createdDate)}"),
          SizedBox(height: 8),
          Text(projectData.description, maxLines: 4),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(height: 2, color: Colors.grey),
          )
        ]));
  }
}
