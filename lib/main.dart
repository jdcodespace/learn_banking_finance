import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learn_banking_finance/connectivitymanager/connectivitymanager.dart';
import 'package:learn_banking_finance/localization/locale_constant.dart';
import 'package:learn_banking_finance/routes/app_pages.dart';
import 'package:learn_banking_finance/routes/app_routes.dart';
import 'package:learn_banking_finance/themes/app_theme.dart';
import 'package:learn_banking_finance/utils/color.dart';
import 'package:learn_banking_finance/utils/constant.dart';
import 'package:learn_banking_finance/utils/debug.dart';
import 'package:learn_banking_finance/utils/preference.dart';
import 'package:learn_banking_finance/utils/utils.dart';
import 'localization/localizations_delegate.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


Future<void> main() async {
  await Preference().instance();
  await InternetConnectivity().instance();

  _configureLocalTimeZone();
  runApp(const MyApp());
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        Debug.printLog(
            "didChangeDependencies Preference Revoked===>>> ${locale.languageCode}");
        Get.updateLocale(locale);
        Debug.printLog(
            " didChangeDependencies GET LOCALE Revoked====>> ${Get.locale!.languageCode}");
      });
    });
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn Banking Finance',
      color: CColor.white,
      translations: AppLanguages(),
      fallbackLocale: const Locale(Constant.languageEn, Constant.countryCodeEn),
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.light,
      locale: Get.deviceLocale,
      getPages: AppPages.list,
      initialRoute:AppRoutes.home,
    );
  }
}

