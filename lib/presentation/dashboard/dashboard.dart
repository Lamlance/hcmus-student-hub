import 'dart:developer';

import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';
import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/dashboard_company.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/dashboard_student.dart';
import 'package:boilerplate/presentation/di/services/get_project_service.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashBoardScreenState();
  }
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final UserStore _userStore = getIt<UserStore>();
  final GetProjectService _projectService = getIt<GetProjectService>();
  final DashBoardStore _dashBoardStore = getIt<DashBoardStore>();
  ProjectStatus seletedStatus = ProjectStatus.none;
  final List<ProjectData> projects = [];

  void handleTabTap(int index) {
    ProjectStatus? newStatus = ProjectStatus.values.asMap()[index];
    if (newStatus != null && seletedStatus != newStatus) {
      setState(() {
        seletedStatus = newStatus;
      });
    }
  }

  _getAllProjects() {
    _projectService.getProjectsByCompanyId(listener: (response, data) {
      if (data != null) {
        setState(() {
          projects.removeWhere((e) => true);
          projects.addAll(data);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getAllProjects();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Student hub"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.profile);
                },
                icon: Icon(Icons.person))
          ],
          flexibleSpace: _userStore.selectedType != AccountType.business
              ? null
              : FlexibleSpaceBar(
                  stretchModes: const <StretchMode>[
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle,
                  ],
                  background: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Your Project"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.PostAProject);
                          },
                          child: Text("Post a Project"),
                        ),
                      ],
                    ),
                  ),
                ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(
                80.0), // Adjust this value as per your requirement
            child: TabBar(onTap: (i) => handleTabTap(i), tabs: [
              Tab(text: "All projects"),
              Tab(text: "Working"),
              Tab(text: "Archived")
            ]),
          ),
        ),
        bottomNavigationBar: MainBottomNavBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            log("REFRESH");
            _getAllProjects();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Observer(
              builder: (ctx) => _userStore.selectedType == AccountType.business
                  ? DashBoardCompanyScreen(
                      seletedStatus: seletedStatus,
                      projects: projects,
                    )
                  : DashBoardStudentScreen(seletedStatus: seletedStatus),
            ),
          ),
        ),
      ),
    );
  }
}
