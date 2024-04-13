import 'dart:async';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/stores/routes/routes_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/presentation/di/services/auth_service.dart';
import 'package:boilerplate/presentation/di/services/get_project_service.dart';
import 'package:boilerplate/presentation/di/services/misc_service.dart';
import 'package:boilerplate/presentation/di/services/profile_service.dart';
import 'package:boilerplate/presentation/di/services/proposal_service.dart';
import 'package:boilerplate/presentation/di/services/post_project_service.dart';
import '../../../di/service_locator.dart';

mixin StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------
    getIt.registerSingleton<UserStore>(UserStore());
    getIt.registerSingleton<DashBoardStore>(DashBoardStore());
    getIt.registerSingleton<RoutesStore>(RoutesStore());

    getIt.registerSingleton<AuthService>(AuthService(
        dioClient: getIt<DioClient>(), userStore: getIt<UserStore>()));
    getIt.registerSingleton<GetProjectService>(GetProjectService(
        dioClient: getIt<DioClient>(),
        userStore: getIt<UserStore>(),
        dashBoardStore: getIt<DashBoardStore>()));
    getIt.registerSingleton<ProfileService>(ProfileService(
        dioClient: getIt<DioClient>(), userStore: getIt<UserStore>()));
    getIt.registerSingleton<MiscService>(
        MiscService(dioClient: getIt<DioClient>()));
    getIt.registerSingleton<ProposalService>(ProposalService(
        dioClient: getIt<DioClient>(), userStore: getIt<UserStore>()));
    getIt.registerSingleton<PostProjectService>(PostProjectService(
        dioClient: getIt<DioClient>(),
        userStore: getIt<UserStore>(),
        dashBoardStore: getIt<DashBoardStore>()));
  }
}
