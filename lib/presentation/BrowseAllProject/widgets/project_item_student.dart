import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/dashboard/project_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProjectItemTab extends StatelessWidget {
  static final DateFormat _dateFormat = DateFormat("dd-MM-yyyy");
  final ProjectData projectData;
  final DashBoardStore _dashBoardStore = getIt<DashBoardStore>();
  final bool displayNumber;
  final Function(ProjectData data)? onOptionClick;

  ProjectItemTab(
      {super.key,
      required this.projectData,
      this.onOptionClick,
      this.displayNumber = true});

  void _onIemClick(BuildContext context) {
    if (displayNumber == false) return;
    _dashBoardStore.setSelectProject(projectData);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => SafeArea(
          child: ProjectDetailScreen(projectData: projectData),
        ),
      ),
    );
  }

  void _onOptionsClick() {
    if (onOptionClick != null) {
      onOptionClick!(projectData);
    }
    _dashBoardStore.setSelectProject(projectData);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => _onIemClick(context),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(projectData.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ...displayNumber
                  ? [
                      IconButton(
                        onPressed: _onOptionsClick,
                        icon: const Icon(Icons.more_horiz),
                        iconSize: 24,
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.grey.shade400)),
                      )
                    ]
                  : []
            ],
          ),
          Text("Created ${_dateFormat.format(projectData.createdDate)}"),
          SizedBox(height: 8),
          Text(projectData.description, maxLines: 4),
          SizedBox(height: 16),
          ...displayNumber
              ? [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(" ${projectData.proposalCount} \n Proposals",
                          maxLines: 2),
                      Text(" ${projectData.messageCount} \n Messages",
                          maxLines: 2),
                      Text(" ${projectData.hiredCount} \n Hired", maxLines: 2)
                    ],
                  )
                ]
              : [],
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(height: 2, color: Colors.grey))
        ]));
  }
}
