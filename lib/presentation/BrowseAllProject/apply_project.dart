import 'dart:developer';

import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/detail.dart';
import 'package:boilerplate/presentation/di/services/proposal_service.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/constants/text.dart';
import 'package:provider/provider.dart';

class ApplyProjectScreen extends StatefulWidget {
  final ProjectData data;
  ApplyProjectScreen({super.key, required this.data});

  @override
  State<StatefulWidget> createState() {
    return _ApplyProjectScreenState();
  }
}

class _ApplyProjectScreenState extends State<ApplyProjectScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _coverLetterController = TextEditingController();
  final ProposalService _proposalService = getIt<ProposalService>();
  final UserStore _userStore = getIt<UserStore>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.title),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          // <--- Info screen --->
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: ProjectDetailInfoScreen(projectData: widget.data),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(onPressed: () {}, child: Text("Saved")),
                      flex: 1,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () => _tabController.animateTo(1),
                        child: Text(
                          Provider.of<LanguageProvider>(context).isEnglish
                              ? AppStrings.applyNow_en
                              : AppStrings.applyNow_vn,
                        ),
                      ),
                      flex: 1,
                    )
                  ],
                ),
              ),
            )
          ]),
          // </-- Info screen --->

          // <--- Cover letter --->
          Form(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    Provider.of<LanguageProvider>(context).isEnglish
                        ? AppStrings.coverLetter_en
                        : AppStrings.coverLetter_vn,
                  ),
                  SizedBox(height: 16),
                  Text(
                    Provider.of<LanguageProvider>(context).isEnglish
                        ? AppStrings.titleDescribe_en
                        : AppStrings.titleDescribe_vn,
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Form(
                      child: TextFormField(
                        controller: _coverLetterController,
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: 10,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText:
                              Provider.of<LanguageProvider>(context).isEnglish
                                  ? AppStrings.coverLetter_en
                                  : AppStrings.coverLetter_vn,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_userStore.selectedUser?.student == null ||
                          _userStore.selectedUser!.student!.id < 0) {
                        return log("Missing student data");
                      }

                      _proposalService.createProposal(
                          request: CreateProposalRequest(
                              projectId: widget.data.id,
                              studentId: _userStore.selectedUser!.student!.id,
                              coverLetter: _coverLetterController.text),
                          listener: (res) {
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.BrowseAllProject);
                          });
                    },
                    child: Text(
                      Provider.of<LanguageProvider>(context).isEnglish
                          ? AppStrings.apply_en
                          : AppStrings.apply_vn,
                    ),
                  ),
                ],
              ),
            ),
          )
          // </-- Cover letter --->
        ],
      ),
    );
  }
}
