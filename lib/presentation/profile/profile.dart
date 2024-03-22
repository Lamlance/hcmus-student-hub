import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/profile/company/company_profile_edit.dart';
import 'package:boilerplate/presentation/profile/company/company_profile_input.dart';
import 'package:boilerplate/presentation/profile/student/student_profile_input.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  static final List<UserData> _savedUser = [
    StudentData(userName: "Lam Student"),
    CompanyData(userName: "Lam Business w/o profile"),
    CompanyData(
        userName: "Lam Business w profile",
        profileData: CompanyProfile(
          companyName: "lam corps",
          website: 'www.lamsite.com',
          desc: 'A large scale db service company',
        ))
  ];

  final UserStore _userStore = getIt<UserStore>();

  String _getAccountSubtitle(AccountType type) {
    switch (type) {
      case AccountType.business:
        return "Business account";
      case AccountType.student:
        return "Student account";
      case AccountType.none:
        return "Unknow account type";
    }
  }

  void onProfileClick(int idx) {
    if (idx >= _savedUser.length) return;
    setState(() {
      _userStore.setSelectedUser(_savedUser[idx]);
      var tmp = _savedUser[0];
      _savedUser[0] = _savedUser[idx];
      _savedUser[idx] = tmp;
    });
  }

  Widget _profileScreen(UserData userData) {
    switch (userData.accountType) {
      case AccountType.business:
        return userData.profileData != null
            ? SafeArea(child: CompanyEditProfile())
            : SafeArea(child: CompanyProfileInputScreen());
      case AccountType.student:
        return SafeArea(child: StudentProfileInputScreen());
      default:
        break;
    }
    return SafeArea(child: CompanyEditProfile());
  }

  void _onProfileClick(BuildContext buildContext) {
    Navigator.push(buildContext,
        MaterialPageRoute(builder: (ctx) => _profileScreen(_savedUser[0])));
  }

  @override
  void initState() {
    super.initState();
    if (_userStore.selectedUser == null) {
      _userStore.setSelectedUser(_savedUser[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget profiles = _savedUser.isEmpty
        ? Text("No saved user available")
        : ExpansionTile(
            title: Text(_savedUser[0].userName),
            subtitle: Text(_getAccountSubtitle(_savedUser[0].accountType)),
            leading: _savedUser[0].accountType == AccountType.business
                ? Icon(Icons.corporate_fare_outlined)
                : Icon(Icons.school_outlined),
            children: [
              ..._savedUser.skip(1).indexed.map((e) => ColoredBox(
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(e.$2.userName),
                      subtitle: Text(_getAccountSubtitle(e.$2.accountType)),
                      leading: e.$2.accountType == AccountType.business
                          ? Icon(Icons.corporate_fare_outlined)
                          : Icon(Icons.school_outlined),
                      onTap: () => onProfileClick(e.$1 + 1),
                    ),
                  ))
            ],
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Hub"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        profiles,
        SizedBox(
          height: 6,
          child: const DecoratedBox(
              decoration: BoxDecoration(color: Colors.amber)),
        ),
        InkWell(
            onTap: () => _onProfileClick(context),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Icon(
                    Icons.person,
                  ),
                ),
                Text("Profile")
              ],
            )),
        InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.login),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Icon(
                    Icons.person,
                  ),
                ),
                Text("Logout")
              ],
            ))
      ]),
    );
  }
}
