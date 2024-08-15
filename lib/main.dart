import 'dart:ui';

import 'package:almirabi/features/authentication/presentation/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'core/config/app_colors.dart';
import 'core/config/app_messages_translation.dart';
import 'core/config/app_shared_pr.dart';
import 'core/config/network_connectivity_checker.dart';
import 'core/utils/db_helper.dart';
import 'features/basic_data_management/request/presentation/view/request_list_screen.dart';
import 'features/remote_database_setting/domain/remote_database_setting_service.dart';
import 'features/remote_database_setting/presentation/remote_database_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NetworkConnectivityChecker.init();
  await SharedPr.init();
  SharedPr.retrieveInfo();
  await DbHelper.getInstance();
  // await RemoteDatabaseSettingService.instantiateOdooConnection();
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
        home: SharedPr.subscriptionDetailsObj?.url == null
            ? const RemoteDatabaseScreen()
            : SharedPr.userObj!.name == null
                ? const LoginScreen()
                : const RequestListScreen());
  }
}
