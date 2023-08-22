import 'dart:developer';
import 'dart:io';

import 'package:app/app/data/presistent/presistent_data.dart';
import 'package:app/app/modules/lanuage_controller.dart';
import 'package:app/app/modules/notification_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/firebase_options.dart';
import 'package:app/generated/generated.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(GlobalNotificationController(), permanent: true);

  Get.put<LanguageController>(LanguageController(), permanent: true);
  Get.put<PresistentData>(PresistentData(), permanent: true);
  Get.put<ThemeController>(ThemeController(), permanent: true);

  final presistentData = Get.find<PresistentData>();
  var isDark = presistentData.getDarkMode() ?? false;

  if (!Platform.isIOS) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: isDark ? Brightness.dark : Brightness.light,
      statusBarColor: isDark ? mainColorDarkTheme : mainColor,
      systemNavigationBarColor: secondaryColor,
    ));
  } else {
    SystemChrome.setSystemUIOverlayStyle(
      isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
    );
  }

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("Asia/Kuwait"));

  runApp(
    ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          final languageController = Get.find<LanguageController>();
          languageController.setLanguage('ar');
          final brightness = MediaQuery.platformBrightnessOf(context);

          final themeController = Get.find<ThemeController>();

          return OverlaySupport.global(
            toastTheme: ToastThemeData(),
            child: GetMaterialApp(
              title: "Fundbucks",
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              fallbackLocale: Locale(Get.deviceLocale?.languageCode ?? 'en'),
              translationsKeys: AppTranslation.translations,
              localizationsDelegates: [
                CountryLocalizations.delegate,
              ],
              theme: themeController.lightTheme,
              darkTheme: themeController.darkTheme,
              themeMode: (presistentData.getDarkMode() ??
                      (brightness == Brightness.dark))
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: GetBuilder<GlobalNotificationController>(
                init: Get.find<GlobalNotificationController>(),
                builder: (_) => child ?? SizedBox(),
              ),
              debugShowCheckedModeBanner: false,
            ),
          );
        }),
  );
}
