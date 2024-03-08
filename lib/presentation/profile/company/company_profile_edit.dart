import 'package:boilerplate/presentation/profile/widgets/company_info_form.dart';
import 'package:flutter/material.dart';

class CompanyEditProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CompanyEditProfileState();
}

class _CompanyEditProfileState extends State<CompanyEditProfile> {
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
                child: CompanyInfoForm())
          ],
        ),
      ),
    );
  }
}
