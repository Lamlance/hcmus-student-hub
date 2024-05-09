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

  void _onOptionsClick() {
    if (widget.onOptionClick != null) {
      widget.onOptionClick!(widget.projectData);
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
                widget.projectData.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  _projectService.makeProjectFav(
                      projectId: widget.projectData.id,
                      isFavorite: !widget.projectData.isFav,
                      listener: (res) {
                        log("Fav status: ${res?.statusCode ?? "null"}");
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
          Text("Created ${_dateFormat.format(widget.projectData.createdDate)}"),
          SizedBox(height: 8),
          Text(widget.projectData.description, maxLines: 4),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Container(height: 2, color: Colors.grey),
          )
        ]));
  }
}
