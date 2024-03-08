import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/profile/profile.dart';

import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/home';
  static const String profile = "/profile";

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeScreen(),
    profile: (BuildContext ctx) => ProfileScreen(),
  };
}
