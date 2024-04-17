import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          // theme: _themeStore.darkMode
          //     ? AppThemeData.darkThemeData
          //     : AppThemeData.lightThemeData,
          initialRoute: Routes.login,
          theme: AppThemeData.lightThemeData,
          routes: Routes.routes,
          // locale: Locale(_languageStore.locale),
          // supportedLocales: _languageStore.supportedLanguages
          //     .map((language) => Locale(language.locale, language.code))
          //     .toList(),
        );
      },
    );
  }
}
