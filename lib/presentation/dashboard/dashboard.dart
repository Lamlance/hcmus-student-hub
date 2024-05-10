import 'dart:developer';

import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';
import 'package:boilerplate/core/widgets/profile_icon_btn.dart';
import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/PostAProject/step1.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/dashboard_company.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/dashboard_student.dart';
import 'package:boilerplate/presentation/di/services/project_service.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/constants/text.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashBoardScreenState();
  }
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final UserStore _userStore = getIt<UserStore>();
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => S1PostAProjectPage(),
                  ),
                );
              },
              icon: Icon(Icons.add),
            ),
            ProfileIconButton()
          ],
          bottom: TabBar(onTap: (i) => handleTabTap(i), tabs: [
            Tab(
              text: Provider.of<LanguageProvider>(context).isEnglish
                  ? AppStrings.allProjects_en
                  : AppStrings.allProjects_vn,
            ),
            Tab(
              text: Provider.of<LanguageProvider>(context).isEnglish
                  ? AppStrings.working_en
                  : AppStrings.working_vn,
            ),
            Tab(
              text: Provider.of<LanguageProvider>(context).isEnglish
                  ? AppStrings.archived_en
                  : AppStrings.archived_vn,
            ),
          ]),
        ),
        bottomNavigationBar: MainBottomNavBar(),
        body: Observer(
          builder: (ctx) => _userStore.selectedType == AccountType.business
              ? DashBoardCompanyScreen(
                  seletedStatus: seletedStatus,
                )
              : DashBoardStudentScreen(seletedStatus: seletedStatus),
        ),
      ),
    );
  }
}
