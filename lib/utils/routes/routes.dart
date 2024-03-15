import 'package:boilerplate/presentation/dashboard/dashboard.dart';
import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/profile/profile.dart';

import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String login = '/login';
  static const String profile = "/profile";
  static const String dashboard = "/dashboard";

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => DashBoardScreen(),
    profile: (BuildContext ctx) => ProfileScreen(),
    dashboard: (context) => DashBoardScreen(),
  };
}
