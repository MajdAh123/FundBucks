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
      fontFamily: fontFamily,
      colorScheme: ColorScheme.fromSwatch(
              backgroundColor: Color(0xFFF6F8FC), brightness: Brightness.light)
          .copyWith(
              surfaceTint: Colors.transparent, surface: Colors.transparent),
    );
  }

  ThemeData get darkTheme {
    String fontFamily = getFontFamilyBasedOnLang();
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      // backgroundColor: Color(0xFF17191F),
      primaryColor: Color(0xFF004366),
      fontFamily: fontFamily,
      colorScheme: ColorScheme.fromSwatch(
              backgroundColor: Color(0xFF17191F), brightness: Brightness.dark)
          .copyWith(
              surfaceTint: Colors.transparent, surface: Colors.transparent),
    );
  }

  // ThemeData get lightTheme {
  //   String fontFamily = getFontFamilyBasedOnLang();
  //   return ThemeData(
  //       brightness: Brightness.light,
  //       // primaryColor: Color(0xFF0579B5),
  //       scaffoldBackgroundColor: Color(0xFFF6F8FC),
  //       fontFamily: fontFamily,
  //       // colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF0579B5)),
  //       // indicatorColor: Color(0xFF0579B5),
  //       colorScheme: ColorScheme.fromSwatch(
  //         primarySwatch: Colors.blue,
  //       ).copyWith(
  //         // primary: Colors.transparent,
  //         secondary: Color(0xFF0579B5),
  //         brightness: Brightness.light,
  //         surfaceTint: Colors.transparent,
  //       ),
  //       switchTheme: SwitchThemeData(),
  //       toggleButtonsTheme: ToggleButtonsThemeData(color: Colors.red)
  //       // popupMenuTheme: PopupMenuThemeData(
  //       //     // surfaceTintColor: Colors.transparent,
  //       //     )
  //       // primaryColorLight: Color(0xFF0579B5),
  //       // datePickerTheme: DatePickerThemeData(
  //       //     surfaceTintColor: Colors.transparent,
  //       //     inputDecorationTheme: InputDecorationTheme(fillColor: mainColor),
  //       //     // MaterialStateColor.resolveWith((states) => mainColor),
  //       //     headerBackgroundColor: Color(0xFF0579B5),
  //       //     confirmButtonStyle: ButtonStyle(
  //       //         foregroundColor:
  //       //             MaterialStateColor.resolveWith((states) => mainColor)),
  //       //     cancelButtonStyle: ButtonStyle(
  //       //         foregroundColor:
  //       //             MaterialStateColor.resolveWith((states) => mainColor)))
  //       // // useMaterial3: false
  //       // colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
  //       );
  // }

  // ThemeData get darkTheme {
  //   String fontFamily = getFontFamilyBasedOnLang();
  //   return ThemeData(
  //     brightness: Brightness.dark,
  //     scaffoldBackgroundColor: Color(0xFF17191F),
  //     // primaryColor: Color(0xFF004366),
  //     fontFamily: fontFamily,
  //     colorScheme: ColorScheme.fromSwatch(
  //       primarySwatch: Colors.blue,
  //     ).copyWith(
  //       // primary: Colors.transparent,
  //       // secondary: mainColorDarkTheme,
  //       brightness: Brightness.dark,

  //       // surfaceTint: Colors.transparent,
  //     ),
  //     textTheme: TextTheme(
  //       bodyLarge: TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       bodyMedium: TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       bodySmall: TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       // bodyText1: TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       // bodyText2: TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       labelLarge: TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       labelMedium: TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       labelSmall: TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       titleMedium: TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       titleSmall: TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       titleLarge: TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       // headlineLarge:
  //       //     TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       // headlineMedium:
  //       //     TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //       // headlineSmall:
  //       //     TextStyle(color: unselectedBottomBarItemColorDarkTheme),
  //     ),
  //     // datePickerTheme: DatePickerThemeData(
  //     //   weekdayStyle: const TextStyle(color: Colors.white),
  //     //   headerForegroundColor: Colors.white,
  //     //   dayForegroundColor: MaterialStateColor.resolveWith(
  //     //       (states) => unselectedBottomBarItemColorDarkTheme),
  //     //   todayForegroundColor:
  //     //       MaterialStateColor.resolveWith((states) => Colors.white),
  //     //   // backgroundColor: const Color(0xff31343b),
  //     //   elevation: .5,
  //     //   yearForegroundColor:
  //     //       MaterialStateColor.resolveWith((states) => Colors.white),
  //     //   backgroundColor: containerColorDarkTheme,
  //     //   headerHelpStyle: TextStyle(color: Colors.red),
  //     //   // inputDecorationTheme:
  //     //   //     InputDecorationTheme(errorStyle: TextStyle(color: Colors.amber))
  //     //   // colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF004366)
  //     // ),
  //   );
  // }

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
