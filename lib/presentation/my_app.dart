import 'dart:developer';

import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/routes/routes_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/core/widgets/main_bottom_navbar.dart';
import 'package:boilerplate/data/models/auth_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/dashboard/dashboard.dart';
import 'package:boilerplate/presentation/di/services/auth_service.dart';
import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/profile/profile.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/core/stores/project/change_notifier.dart';
import 'package:boilerplate/presentation/di/services/post_project_service.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProjectDataNotifier()),
        Provider(
            create: (_) => PostProjectService(
                dioClient: null,
                userStore: null,
                dashBoardStore: null /* dependencies here */)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Strings.appName,
        theme: AppThemeData.lightThemeData,
        initialRoute: Routes.login,
        routes: Routes.routes,
        // locale: Locale(_languageStore.locale),
        // supportedLocales: _languageStore.supportedLanguages
        //     .map((language) => Locale(language.locale, language.code))
        //     .toList(),
      ),
    );
  }
}
