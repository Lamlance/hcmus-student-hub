import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/detail.dart';
import 'package:boilerplate/presentation/dashboard/widgets/project_item.dart';
import 'package:flutter/material.dart';

class DashBoardStudentScreen extends StatelessWidget {
  final ProjectStatus seletedStatus;
  final DashBoardStore _dashBoardStore = getIt<DashBoardStore>();

  DashBoardStudentScreen({super.key, this.seletedStatus = ProjectStatus.none});

  Iterable<Widget> _buildProjectItem() {
    return switch (seletedStatus) {
      (ProjectStatus.working) => _dashBoardStore.projects
          .where((p) => p.status == ProjectStatus.working)
          .map((e) => ProjectDetailInfoScreen(projectData: e)),
      (ProjectStatus.none) => [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Active proposal"),
                SizedBox(height: 16),
                ..._dashBoardStore.projects
                    .where((e) => e.hireStatus == HireStatus.activePropose)
                    .map((e) =>
                        ProjectItem(projectData: e, displayNumber: false))
              ],
            ),
          ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Proposal"),
                SizedBox(height: 16),
                ..._dashBoardStore.projects
                    .where((e) => e.hireStatus == HireStatus.propose)
                    .map((e) =>
                        ProjectItem(projectData: e, displayNumber: false))
              ],
            ),
          )
        ],
      _ => [Text("Empty")]
    };
  }

  @override
  Widget build(BuildContext context) {
    var tabProjects = _buildProjectItem();
    return Column(
      children: [SizedBox(height: 16), ...tabProjects],
    );
  }
}
