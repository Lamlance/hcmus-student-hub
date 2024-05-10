import 'dart:async';

import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LanguageProvider with ChangeNotifier {
  bool _isEnglish = true;

  bool get isEnglish => _isEnglish;

  void switchLanguage() {
    _isEnglish = !_isEnglish;
    notifyListeners();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  await ServiceLocator.configureDependencies();
  runApp(
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
      child: MyApp(),
    ),
  );
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
