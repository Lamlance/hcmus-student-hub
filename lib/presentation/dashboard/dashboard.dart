import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/dashboard_company.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/dashboard_student.dart';
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

  ProjectStatus seletedStatus = ProjectStatus.none;

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
          flexibleSpace: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Student hub"),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.profile);
                        },
                        icon: Icon(Icons.person))
                  ],
                ),
                //SizedBox(height: 10), // Add some spacing
                Row(
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
              ],
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
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Observer(
              builder: (ctx) => _userStore.selectedType == AccountType.business
                  ? DashBoardCompanyScreen(seletedStatus: seletedStatus)
                  : DashBoardStudentScreen(seletedStatus: seletedStatus)),
        ),
      ),
    );
  }
}
