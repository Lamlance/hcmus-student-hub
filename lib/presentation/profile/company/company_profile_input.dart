import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/profile/widgets/company_info_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompanyProfileInputScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CompanyProfileInputScreenState();
}

class _CompanyProfileInputScreenState extends State<CompanyProfileInputScreen> {
  final UserStore _userStore = getIt<UserStore>();

  static const String welcomeTxt = "Welcome to student hub";
  static const String descTxt =
      "Tell us about your company and you will be on your way connect with high-skilled students";
  static const EdgeInsets listTilePadding =
      EdgeInsets.symmetric(horizontal: 16);
  CompanySize? _companySize = CompanySize.only1;

  ListTile _makeEmployeeSizeRadio(String label, CompanySize companySize) {
    return ListTile(
      dense: true,
      onTap: () => _onCompanyRadioSelect(companySize),
      contentPadding: listTilePadding,
      title: Text(
        label,
        style: TextStyle(fontSize: 16),
      ),
      leading: Radio<CompanySize>(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: companySize,
        groupValue: _companySize,
        onChanged: _onCompanyRadioSelect,
      ),
    );
  }

  void _onCompanyRadioSelect(CompanySize? size) {
    setState(() {
      _companySize = size;
    });
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
                  child: CompanyInfoForm()),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom * 2),
              ),
            ])));
  }
}
