import 'dart:developer';

import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/BrowseAllProject/apply_project.dart';
import 'package:boilerplate/presentation/di/services/project_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectItemTab extends StatefulWidget {
  final ProjectData projectData;
  final Function(ProjectData data)? onOptionClick;
  ProjectItemTab({
    super.key,
    required this.projectData,
    this.onOptionClick,
  });
  @override
  State<StatefulWidget> createState() {
    return _ProjectItemTabState();
  }
}

class _ProjectItemTabState extends State<ProjectItemTab> {
  static final DateFormat _dateFormat = DateFormat("dd-MM-yyyy");
  final _projectService = getIt<ProjectService>();
  final _dashboardStore = getIt<DashBoardStore>();
  ProjectData? projectData;

  void _onIemClick(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => SafeArea(
          child: ApplyProjectScreen(data: widget.projectData),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      projectData = widget.projectData;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (projectData == null) {
      return Text("Loading");
    }

    return InkWell(
        onTap: () => _onIemClick(context),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                projectData!.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  _projectService.makeProjectFav(
                      projectId: projectData!.id,
                      isFavorite: !projectData!.isFav,
                      listener: (res) {
                        log("Fav status: ${res?.statusCode ?? "null"}");
                        setState(() {
                          projectData!.isFav = !projectData!.isFav;
                          _dashboardStore.updateProject(projectData!);
                        });
                      });
                },
                icon: !widget.projectData.isFav
                    ? Icon(Icons.favorite_border)
                    : Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
              )
            ],
          ),
          Text("Created ${_dateFormat.format(projectData!.createdDate)}"),
          SizedBox(height: 8),
          Text(projectData!.description, maxLines: 4),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(height: 2, color: Colors.grey),
          )
        ]));
  }
}
