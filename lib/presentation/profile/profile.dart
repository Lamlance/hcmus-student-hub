import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/auth_service.dart';
import 'package:boilerplate/presentation/di/services/profile_service.dart';
import 'package:boilerplate/presentation/di/services/socket_service.dart';
import 'package:boilerplate/presentation/profile/company/company_profile_edit.dart';
import 'package:boilerplate/presentation/profile/company/company_profile_input.dart';
import 'package:boilerplate/presentation/profile/student/student_input.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _userStore = getIt<UserStore>();
  final _socketService = getIt<SocketChatService>();
  final _authService = getIt<AuthService>();
  AccountType _selectType = AccountType.none;

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

  void onProfileClick(AccountType type) {
    setState(() {
      _selectType = type;
    });
    _userStore.setSelectedType(type);
  }

  Widget _profileScreen(UserData userData) {
    switch (_selectType) {
      case AccountType.business:
        return SafeArea(child: CompanyProfileInputScreen());
      case AccountType.student:
        return SafeArea(child: StudentInputScreen());
      default:
        break;
    }
    return SafeArea(child: CompanyEditProfile());
  }

  void _onProfileClick(BuildContext buildContext) {
    Navigator.push(
        buildContext,
        MaterialPageRoute(
            builder: (ctx) => _profileScreen(_userStore.selectedUser!)));
  }

  void _refreshUserData() {
    _authService.authMe(
      token: _userStore.token!,
      listener: (res, data) {
        if (data == null) return;
        _userStore.setSelectedUser(data, accessToken: _userStore.token);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    final firstProfile = _userStore.selectedUser
        ?.getProfiles()
        .where((e) => e.id != -1)
        .firstOrNull;
    _userStore.setSelectedType(firstProfile?.type ?? AccountType.student);
    setState(() {
      _selectType = firstProfile?.type ?? AccountType.student;
    });
    _socketService.connectToNotification(_userStore.selectedUser!.userId);
  }

  @override
  Widget build(BuildContext context) {
    final user = _userStore.selectedUser;
    if (user == null) {
      return Text("No user found");
    }
    final profilesData = user.getProfiles();
    profilesData.sort((a, b) {
      if (_selectType == AccountType.none) {
        return 0;
      }
      return _selectType == a.type ? -1 : 1;
    });

    Widget profiles = profilesData.isEmpty
        ? Text("No saved user available")
        : ExpansionTile(
            title: Text(user.fullName),
            subtitle: Text(_getAccountSubtitle(profilesData.first.type)),
            leading: profilesData.first.type == AccountType.business
                ? Icon(Icons.corporate_fare_outlined)
                : Icon(Icons.school_outlined),
            children: [
              ...profilesData.skip(1).map((e) => ColoredBox(
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(user.fullName),
                      subtitle: Text(_getAccountSubtitle(e.type)),
                      leading: e.type == AccountType.business
                          ? Icon(Icons.corporate_fare_outlined)
                          : Icon(Icons.school_outlined),
                      onTap: () => onProfileClick(e.type),
                    ),
                  ))
            ],
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Hub"),
      ),
      bottomNavigationBar: switch (_selectType) {
        AccountType.none => null,
        AccountType.business =>
          _userStore.selectedUser?.company == null ? null : MainBottomNavBar(),
        AccountType.student =>
          _userStore.selectedUser?.student == null ? null : MainBottomNavBar()
      },
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshUserData();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Icon(
                          Icons.person,
                        ),
                      ),
                      Text("Profile")
                    ],
                  )),
              InkWell(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.login),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Icon(Icons.person_off_rounded),
                    ),
                    Text("Logout")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
