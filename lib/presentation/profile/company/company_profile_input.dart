import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/profile_service.dart';
import 'package:boilerplate/presentation/profile/widgets/company_info_form.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';

class CompanyProfileInputScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CompanyProfileInputScreenState();
}

class _CompanyProfileInputScreenState extends State<CompanyProfileInputScreen> {
  final ProfileService _profileService = getIt<ProfileService>();
  final _userStore = getIt<UserStore>();
  static const String welcomeTxt = "Welcome to student hub";
  static const String descTxt =
      "Tell us about your company and you will be on your way connect with high-skilled students";

  void _handleSubmitProfile(CompanyProfile profile) {
    if (_userStore.selectedUser?.company != null) {
      return;
    }
    _profileService.createCompanyProfile(
      profile: CreateCompanyProfile(
        companyName: profile.companyName,
        companySize: switch (profile.companySize) {
          CompanySize.only1 => 0,
          CompanySize.less9 => 1,
          CompanySize.less99 => 2,
          CompanySize.less1000 => 3,
          CompanySize.more1000 => 4
        },
        website: profile.website,
        description: profile.desc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Student hub"),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(children: [
          const Text(welcomeTxt),
          SizedBox(height: 6),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Text(descTxt)),
          SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CompanyInfoForm(onSubmit: _handleSubmitProfile),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom * 2),
          ),
        ]),
      ),
    );
  }
}
