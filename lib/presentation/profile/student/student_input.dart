import 'package:boilerplate/data/models/misc_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/profile_service.dart';
import 'package:boilerplate/presentation/profile/student/student_cv_input.dart';
import 'package:boilerplate/presentation/profile/student/student_experience_input.dart';
import 'package:boilerplate/presentation/profile/student/student_profile_input.dart';
import 'package:boilerplate/utils/routes/routes.dart';
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
  final ProfileService _profileService = getIt<ProfileService>();

  final List<SkillSetData> _skillSetList = [];
  TechStackData? _techStackData;

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
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          StudentProfileInputScreen(
            onFinishInput: (tech, skill) {
              _skillSetList.removeWhere((e) => true);
              _skillSetList.addAll(skill);
              _techStackData = tech;
              _tabController.animateTo(1);
            },
          ),
          StudentExperienceInputScreen(
            onFinishInput: () => _tabController.animateTo(2),
          ),
          StudentCVInputScreen(
            onFinishInput: () {
              if (_techStackData == null || _skillSetList.isEmpty) return;
              _profileService.createStudentProfile(
                profile: CreateStudentProfile(
                    techStackId: _techStackData!.id,
                    skillSets: _skillSetList.map((e) => e.id).toList()),
                listener: (res) {
                  Navigator.of(context).pushReplacementNamed(Routes.profile);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
