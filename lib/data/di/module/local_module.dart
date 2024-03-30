import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../di/service_locator.dart';

mixin LocalModule {
  static Future<void> configureLocalModuleInjection() async {
    // preference manager:------------------------------------------------------
    getIt.registerSingletonAsync<SharedPreferences>(
        SharedPreferences.getInstance);
    // getIt.registerSingleton<SharedPreferenceHelper>(
    //   SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()),
    // );

    // database:----------------------------------------------------------------

    // getIt.registerSingletonAsync<SembastClient>(
    //   () async => SembastClient.provideDatabase(
    //     databaseName: DBConstants.DB_NAME,
    //     databasePath: kIsWeb
    //         ? "/assets/db"
    //         : (await getApplicationDocumentsDirectory()).path,
    //   ),
    // );

    // data sources:------------------------------------------------------------
    // getIt.registerSingleton(
    //     PostDataSource(await getIt.getAsync<SembastClient>()));
  }
}
