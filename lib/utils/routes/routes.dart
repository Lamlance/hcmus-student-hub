import 'package:boilerplate/presentation/BrowseAllProject/ProjectList.dart';
import 'package:boilerplate/presentation/dashboard/dashboard.dart';
import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/message/message.dart';
import 'package:boilerplate/presentation/profile/profile.dart';
import 'package:boilerplate/presentation/signup/signup.dart';
import 'package:boilerplate/presentation/signup/signupType.dart';
import 'package:boilerplate/presentation/PostAProject/step1.dart';
import 'package:boilerplate/presentation/BrowseAllProject/ProjectList.dart';
import 'package:boilerplate/presentation/alert/alert.dart';

import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String login = '/login';
  static const String signUpType = '/signUpType';
  static const String signUp = '/signUp';

  static const String profile = "/profile";
  static const String dashboard = "/dashboard";
  static const String PostAProject = "/PostAProject";
  static const String message = "/message";
  static const String BrowseAllProject = "/BrowseAllProject";
  static const String alert = "/alert";
  static const String initialRoute = Routes.dashboard;

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginPage(),
    profile: (BuildContext ctx) => ProfileScreen(),
    dashboard: (context) => DashBoardScreen(),
    message: (context) => MessageScreen(),
    signUpType: (ctx) => SignupTypePage(),
    signUp: (ctx) => SignupPage(accountType: 0)
    PostAProject: (context) => S1PostAProjectPage(),
    BrowseAllProject: (context) => ProjectList(),
    alert: (context) => AlertScreen(),
  };
}
