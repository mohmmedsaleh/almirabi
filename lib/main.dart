import 'dart:ui';

import 'package:almirabi/core/config/app_urls.dart';
import 'package:almirabi/features/authentication/presentation/views/login_screen.dart';
import 'package:almirabi/features/basic_data_management/request/presentation/view/request_list_screen.dart';
import 'package:almirabi/features/remote_database_setting/domain/remote_database_setting_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pos_package/core/config/app_shared_pr.dart' as SharedPrPackage;
import 'core/config/app_colors.dart';
import 'core/config/app_messages_translation.dart';
import 'core/config/app_shared_pr.dart';
import 'core/utils/db_helper.dart';
import 'features/remote_database_setting/presentation/remote_database_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NetworkConnectivityChecker.init();
  await SharedPr.init();
  await SharedPrPackage.SharedPr.init();
  SharedPr.retrieveInfo();
  await DbHelper.getInstance();
  await RemoteDatabaseSettingService.instantiateOdooConnection(
      url: remoteURL,
      db: remotedB,
      username: remoteUsername,
      password: remotePassword);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Almirabi'.tr,
        debugShowCheckedModeBanner: false,
        translations: Messages(),
        locale: Locale(SharedPr.lang ?? 'en'),
        fallbackLocale: const Locale('en'),
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          },
        ),
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: AppColor.black,
                fontFamily: 'Tajawal',
              ),
        ),
        home:
            //  SharedPrPackage.
            SharedPr.subscriptionDetailsObj?.url == null
                ? const RemoteDatabaseScreen2()
                : SharedPr.userObj?.name == null
                    ?
                    // TokenScreen()
                    const LoginScreen2()
                    : const RequestListScreen2());
  }
}
