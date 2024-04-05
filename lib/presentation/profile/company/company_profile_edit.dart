import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/profile_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/profile_service.dart';
import 'package:boilerplate/presentation/profile/widgets/company_info_form.dart';
import 'package:flutter/material.dart';

class CompanyEditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CompanyEditProfileState();
}

class _CompanyEditProfileState extends State<CompanyEditProfile> {
  final ProfileService _profileService = getIt<ProfileService>();
  final UserStore _userStore = getIt<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student hub"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: CompanyInfoForm(
                onSubmit: (profile) {
                  final companyId = _userStore.selectedUser?.company?.id;
                  if (companyId == null || companyId < 0) return;
                  _profileService.updateCompanyProfile(
                    profile: UpdateCompanyProfile(
                        companyId: companyId,
                        companyName: profile.companyName,
                        companySize: 69,
                        website: profile.website,
                        description: profile.desc),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
