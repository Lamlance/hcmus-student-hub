import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:flutter/material.dart';

class ProfileInputScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileInputScreenState();
}

class _ProfileInputScreenState extends State<ProfileInputScreen> {
  final UserStore _userStore = getIt<UserStore>();

  static const String welcomeTxt = "Welcome to student hub";
  static const String descTxt =
      "Tell us about your company and you will be on your way connect with high-skilled students";
  static const EdgeInsets listTilePadding =
      EdgeInsets.symmetric(horizontal: 16);
  CompanySize? _companySize = CompanySize.only1;

  @override
  Widget build(BuildContext context) {
    void onCompanyRadioSelect(CompanySize? size) {
      setState(() {
        _companySize = size;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Student hub"),
        ),
        body: Column(children: [
          Text("Selected ${_userStore.selectedUser?.userName ?? "No user"}"),
          const Text(welcomeTxt),
          SizedBox(height: 6),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Text(descTxt)),
          SizedBox(height: 24),
          const Text("How many people are in your company"),
          ListTile(
            dense: true,
            onTap: () => onCompanyRadioSelect(CompanySize.only1),
            contentPadding: listTilePadding,
            title: const Text("Only me"),
            leading: Radio<CompanySize>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: CompanySize.only1,
              groupValue: _companySize,
              onChanged: onCompanyRadioSelect,
            ),
          ),
          ListTile(
            dense: true,
            onTap: () => onCompanyRadioSelect(CompanySize.less9),
            contentPadding: listTilePadding,
            title: const Text("2-9 employees"),
            leading: Radio<CompanySize>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: CompanySize.less9,
              groupValue: _companySize,
              onChanged: onCompanyRadioSelect,
            ),
          ),
          ListTile(
            dense: true,
            onTap: () => onCompanyRadioSelect(CompanySize.less99),
            contentPadding: listTilePadding,
            title: const Text("10-99 employees"),
            leading: Radio<CompanySize>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: CompanySize.less99,
              groupValue: _companySize,
              onChanged: onCompanyRadioSelect,
            ),
          ),
          ListTile(
            dense: true,
            onTap: () => onCompanyRadioSelect(CompanySize.less1000),
            contentPadding: listTilePadding,
            title: const Text("100-10000 employees"),
            leading: Radio<CompanySize>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: CompanySize.less1000,
              groupValue: _companySize,
              onChanged: onCompanyRadioSelect,
            ),
          ),
          ListTile(
            onTap: () => onCompanyRadioSelect(CompanySize.more1000),
            contentPadding: listTilePadding,
            title: const Text("More than 1000 employees"),
            leading: Radio<CompanySize>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              value: CompanySize.more1000,
              groupValue: _companySize,
              onChanged: onCompanyRadioSelect,
            ),
          )
        ]));
  }
}
