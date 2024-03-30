import 'package:boilerplate/presentation/dashboard/dashboard.dart';
import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/message/message.dart';
import 'package:boilerplate/presentation/profile/profile.dart';

import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String login = '/login';
  static const String profile = "/profile";
  static const String dashboard = "/dashboard";
  static const String message = "/message";

  static const String initialRoute = Routes.dashboard;

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginPage(),
    profile: (BuildContext ctx) => ProfileScreen(),
    dashboard: (context) => DashBoardScreen(),
    message: (context) => MessageScreen()
  };
}
