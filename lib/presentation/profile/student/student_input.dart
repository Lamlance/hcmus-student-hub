import 'package:boilerplate/presentation/profile/student/student_cv_input.dart';
import 'package:boilerplate/presentation/profile/student/student_experience_input.dart';
import 'package:boilerplate/presentation/profile/student/student_profile_input.dart';
import 'package:flutter/material.dart';

class StudentInputScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentInputScreenState();
  }
}

class _StudentInputScreenState extends State<StudentInputScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student profile"),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StudentProfileInputScreen(
            onFinishInput: () => _tabController.animateTo(1),
          ),
          StudentExperienceInputScreen(
            onFinishInput: () => _tabController.animateTo(2),
          ),
          StudentCVInputScreen(
            onFinishInput: () {},
          )
        ],
      ),
    );
  }
}
