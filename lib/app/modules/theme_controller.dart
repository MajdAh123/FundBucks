import 'dart:developer';
import 'dart:io';

import 'package:app/app/data/presistent/presistent_data.dart';
import 'package:app/app/modules/lanuage_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  var isDarkMode = false.obs;

  bool get getIsDarkMode => isDarkMode.value;

  final languageController = Get.find<LanguageController>();

  getFontFamilyBasedOnLang() {
    return languageController.getLanguage().compareTo('ar') == 0
        ? FontFamily.tajawal
        : FontFamily.inter;
  }

  ThemeData get lightTheme {
    String fontFamily = getFontFamilyBasedOnLang();
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Color(0xFF0579B5),
      backgroundColor: Color(0xFFF6F8FC),
      fontFamily: fontFamily,
    );
  }

  ThemeData get darkTheme {
    String fontFamily = getFontFamilyBasedOnLang();
    return ThemeData(
      brightness: Brightness.dark,
      backgroundColor: Color(0xFF17191F),
      primaryColor: Color(0xFF004366),
      fontFamily: fontFamily,
    );
  }

  @override
  void onInit() {
    final presistentData = Get.find<PresistentData>();
    isDarkMode.value = presistentData.getDarkMode() ?? false;
    // setLanguage(presistentData.readLocaleCode());
    print('Theme: ${isDarkMode.value}');

    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    update();

    super.onInit();
  }

  void toggleTheme() {
    final presistentData = Get.find<PresistentData>();
    isDarkMode.toggle();
    presistentData.writeDarkMode(isDarkMode.value);
    presistentData.update();
    log("isDarkMode: $isDarkMode");
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    update();
    Get.appUpdate();
    if (!Platform.isIOS) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness:
            isDarkMode.value ? Brightness.dark : Brightness.light,
        statusBarColor: isDarkMode.value ? mainColorDarkTheme : mainColor,
        systemNavigationBarColor: secondaryColor,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        isDarkMode.value
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
      );
    }
  }
}
