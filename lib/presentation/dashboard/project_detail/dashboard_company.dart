import 'dart:developer';
import 'package:boilerplate/core/stores/misc/misc_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/PostAProject/step1.dart';
import 'package:boilerplate/presentation/dashboard/project_detail.dart';
import 'package:boilerplate/presentation/dashboard/widgets/project_item.dart';
import 'package:boilerplate/presentation/di/services/project_service.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/constants/text.dart';

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
  final List<ProjectData> _projects = [];
  final ProjectService _projectService = getIt<ProjectService>();
  final _miscStore = getIt<MiscStore>();
  final _dashBoardStore = getIt<DashBoardStore>();

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
            TextButton(
              onPressed: () {
                _dashBoardStore.setSelectProject(data);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => SafeArea(
                      child: ProjectDetailScreen(projectData: data),
                    ),
                  ),
                );
              },
              child: Text(
                _miscStore.isEnglish
                    ? AppStrings.viewProposal_en
                    : AppStrings.viewProposal_vn,
              ),
            ),
            TextButton(
              onPressed: () {
                _dashBoardStore.setSelectProject(data);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => SafeArea(
                      child: ProjectDetailScreen(projectData: data),
                    ),
                  ),
                );
              },
              child: Text(
                _miscStore.isEnglish
                    ? AppStrings.viewMessage_en
                    : AppStrings.viewMessage_vn,
              ),
            ),
            TextButton(
              onPressed: () {
                _dashBoardStore.setSelectProject(data);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => SafeArea(
                      child: ProjectDetailScreen(projectData: data),
                    ),
                  ),
                );
              },
              child: Text(
                _miscStore.isEnglish
                    ? AppStrings.viewHired_en
                    : AppStrings.viewHired_vn,
              ),
            ),
            Divider(color: Colors.black),
            TextButton(
              onPressed: () {},
              child: Text(
                _miscStore.isEnglish
                    ? AppStrings.viewJobPosting_en
                    : AppStrings.viewJobPosting_vn,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(buildContext).push(
                  MaterialPageRoute(
                    builder: (ctx) => S1PostAProjectPage(
                      projectData: data,
                    ),
                  ),
                );
              },
              child: Text(
                _miscStore.isEnglish
                    ? AppStrings.editPost_en
                    : AppStrings.editPost_vn,
              ),
            ),
            TextButton(
              onPressed: () {
                _projectService.deleteProject(
                  projectId: data.id,
                  listener: (res) {
                    if (res.statusCode == 200) {
                      _getAllProjects();
                      Navigator.pop(buildContext);
                    }
                  },
                );
              },
              child: Text(
                _miscStore.isEnglish
                    ? AppStrings.removePost_en
                    : AppStrings.removePost_vn,
              ),
            ),
            Divider(color: Colors.black),
            TextButton(
              onPressed: () {
                _projectService.closeProject(
                  data: data,
                  isSuccess: true,
                  listener: (res) {
                    log("Close as succeed: ${res.statusCode}");
                    _getAllProjects();
                    Navigator.pop(buildContext);
                  },
                );
              },
              child: Text(
                _miscStore.isEnglish
                    ? AppStrings.closeProject_en
                    : AppStrings.closeProject_vn,
              ),
            ),
            TextButton(
              onPressed: () {
                _projectService.closeProject(
                  data: data,
                  isSuccess: false,
                  listener: (res) {
                    log("Remove posting: ${res.statusCode}");
                    _getAllProjects();
                    Navigator.pop(buildContext);
                  },
                );
              },
              child: Text(
                _miscStore.isEnglish
                    ? AppStrings.closeProjectFail_en
                    : AppStrings.closeProjectFail_vn,
              ),
            ),
            Divider(color: Colors.black),
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
                            _getAllProjects();
                            Navigator.pop(buildContext);
                          },
                        );
                      },
                      child: Text(
                        _miscStore.isEnglish
                            ? AppStrings.startWorking_en
                            : AppStrings.startWorking_vn,
                      ),
                    )
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
        enableDrag: true,
        isDismissible: true,
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
    return RefreshIndicator(
      onRefresh: () async {
        log("REFRESH");
        _getAllProjects();
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [...tabProjects],
        ),
      ),
    );
  }
}
