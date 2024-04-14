import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/dashboard/widgets/project_item.dart';
import 'package:flutter/material.dart';

class DashBoardCompanyScreen extends StatelessWidget {
  final ProjectStatus seletedStatus;
  final DashBoardStore _dashBoardStore = getIt<DashBoardStore>();
  final List<ProjectData> _projects = [];

  DashBoardCompanyScreen(
      {super.key,
      this.seletedStatus = ProjectStatus.none,
      List<ProjectData>? projects}) {
    if (projects != null) _projects.addAll(projects);
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
                          data.status = ProjectStatus.working;
                          _dashBoardStore.updateProject(data);
                          Navigator.pop(buildContext);
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
            seletedStatus == ProjectStatus.none || seletedStatus == p.status)
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
