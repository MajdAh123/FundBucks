import 'dart:io';

import 'package:app/app/modules/lanuage_controller.dart';
import 'package:app/app/modules/notification_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/firebase_options.dart';
import 'package:app/generated/generated.dart';
import 'package:firebase_core/firebase_core.dart';
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
  // Get.put(GlobalNotificationController());

  Get.put<LanguageController>(LanguageController());

  if (!Platform.isIOS) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: mainColor,
      systemNavigationBarColor: secondaryColor,
    ));
  } else {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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
          return OverlaySupport.global(
            child: GetMaterialApp(
              title: "Fundbucks",
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
              // supportedLocales: [
              //   Locale('ar'),
              //   Locale('en'),
              // ],
              // locale: Locale(languageController.getLanguage()),
              fallbackLocale: Locale(Get.deviceLocale?.languageCode ?? 'en'),
              // theme: ThemeData.light(),
              translationsKeys: AppTranslation.translations,
              theme: ThemeData(
                fontFamily:
                    languageController.getLanguage().compareTo('ar') == 0
                        ? FontFamily.tajawal
                        : FontFamily.inter,
                primarySwatch: Colors.blue,
              ),
              home: GetBuilder<GlobalNotificationController>(
                builder: (_) => child ?? SizedBox(),
                init: GlobalNotificationController(),
              ),
              debugShowCheckedModeBanner: false,
            ),
          );
        }),
  );
}

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }
