import 'dart:async';
import '../../../di/service_locator.dart';

mixin RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    // getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
    //   getIt<SharedPreferenceHelper>(),
    // ));

    // getIt.registerSingleton<UserRepository>(UserRepositoryImpl(
    //   getIt<SharedPreferenceHelper>(),
    // ));

    // getIt.registerSingleton<PostRepository>(PostRepositoryImpl(
    //   getIt<PostApi>(),
    //   getIt<PostDataSource>(),
    // ));
  }
}
