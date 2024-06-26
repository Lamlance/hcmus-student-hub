import 'dart:async';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/core/stores/misc/misc_store.dart';
import 'package:boilerplate/core/stores/routes/routes_store.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/presentation/di/services/agora_service.dart';
import 'package:boilerplate/presentation/di/services/auth_service.dart';
import 'package:boilerplate/presentation/di/services/project_service.dart';
import 'package:boilerplate/presentation/di/services/interview_service.dart';
import 'package:boilerplate/presentation/di/services/message_service.dart';
import 'package:boilerplate/presentation/di/services/misc_service.dart';
import 'package:boilerplate/presentation/di/services/notification_service.dart';
import 'package:boilerplate/presentation/di/services/profile_service.dart';
import 'package:boilerplate/presentation/di/services/proposal_service.dart';
import 'package:boilerplate/presentation/di/services/socket_service.dart';
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
    getIt.registerSingleton<LocalNotificationService>(
      LocalNotificationService(),
    );
    getIt.registerSingleton<MiscStore>(MiscStore());
    getIt.registerSingleton<UserStore>(UserStore());
    getIt.registerSingleton<DashBoardStore>(DashBoardStore());
    getIt.registerSingleton<RoutesStore>(RoutesStore());

    getIt.registerSingleton<AuthService>(AuthService(
        dioClient: getIt<DioClient>(), userStore: getIt<UserStore>()));
    getIt.registerSingleton<ProjectService>(ProjectService(
        dioClient: getIt<DioClient>(),
        userStore: getIt<UserStore>(),
        dashBoardStore: getIt<DashBoardStore>()));
    getIt.registerSingleton<ProfileService>(ProfileService(
        dioClient: getIt<DioClient>(), userStore: getIt<UserStore>()));
    getIt.registerSingleton<MiscService>(
        MiscService(dioClient: getIt<DioClient>()));
    getIt.registerSingleton<ProposalService>(ProposalService(
        dioClient: getIt<DioClient>(), userStore: getIt<UserStore>()));
    getIt.registerSingleton<MessageService>(MessageService(
      dioClient: getIt<DioClient>(),
      userStore: getIt<UserStore>(),
    ));
    getIt.registerSingleton<SocketChatService>(
      SocketChatService(
          dioClient: getIt<DioClient>(),
          userStore: getIt<UserStore>(),
          notificationService: getIt<LocalNotificationService>()),
    );
    getIt.registerSingleton<InterviewService>(InterviewService(
      dioClient: getIt<DioClient>(),
      userStore: getIt<UserStore>(),
    ));

    getIt.registerSingleton<AgoraSerivce>(AgoraSerivce(
      dioClient: getIt<DioClient>(),
      userStore: getIt<UserStore>(),
    ));
  }
}
