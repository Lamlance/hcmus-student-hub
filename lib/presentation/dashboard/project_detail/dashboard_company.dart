import 'dart:developer';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/dashboard/widgets/project_item.dart';
import 'package:boilerplate/presentation/di/services/project_service.dart';
import 'package:flutter/material.dart';

class DashBoardCompanyScreen extends StatefulWidget {
  final ProjectStatus seletedStatus;

  DashBoardCompanyScreen({
    super.key,
    this.seletedStatus = ProjectStatus.none,
  });

  @override
  State<StatefulWidget> createState() {
    return _DashBoardCompanyScreenState();
  }
}

class _DashBoardCompanyScreenState extends State<DashBoardCompanyScreen> {
  final DashBoardStore _dashBoardStore = getIt<DashBoardStore>();
  final List<ProjectData> _projects = [];
  final ProjectService _projectService = getIt<ProjectService>();

  _getAllProjects() {
    _projectService.getProjectsByCompanyId(listener: (response, data) {
      if (data != null) {
        setState(() {
          _projects.removeWhere((e) => true);
          _projects.addAll(data);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllProjects();
  }

  Widget _buildBottomSheet(BuildContext buildContext, ProjectData data) {
    return Wrap(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            TextButton(onPressed: () {}, child: const Text("View proposals")),
            TextButton(onPressed: () {}, child: const Text("View messages")),
            TextButton(onPressed: () {}, child: const Text("View hired")),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Container(height: 2, color: Colors.grey)),
            TextButton(onPressed: () {}, child: const Text("View job posting")),
            TextButton(onPressed: () {}, child: const Text("Edit posting")),
            TextButton(onPressed: () {}, child: const Text("Remove posting")),
            ...(data.status != ProjectStatus.working &&
                    data.hiredCount == data.numberOfStudent
                ? [
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Container(height: 2, color: Colors.grey)),
                    TextButton(
                        onPressed: () {
                          _projectService.startWorkingOnProject(
                            data: data,
                            listener: (res) {
                              log("Start working: ${res.statusCode}");
                            },
                          );
                        },
                        child: const Text("Start working"))
                  ]
                : [])
          ],
        )
      ],
    );
  }

  void _showModalBottomSheet(
      BuildContext buildContext, ProjectData projectData) {
    showModalBottomSheet(
        context: buildContext,
        builder: (ctx) => _buildBottomSheet(ctx, projectData));
  }

  @override
  Widget build(BuildContext context) {
    var tabProjects = _projects
        .where((p) =>
            widget.seletedStatus == ProjectStatus.none ||
            widget.seletedStatus == p.status)
        .map((e) {
      return ProjectItem(
        projectData: e,
        onOptionClick: (p) => _showModalBottomSheet(context, p),
      );
    });
    return Column(
      children: [...tabProjects],
    );
  }
}
