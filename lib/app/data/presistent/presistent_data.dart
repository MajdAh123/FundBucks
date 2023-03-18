import 'package:app/generated/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PresistentData extends GetxController {
  final box = GetStorage();
  final String localeCodeKey = 'LOCALE_CODE_KEY';
  final String authToken = 'AUTH_TOKEN';
  final String fcmToken = 'FCM_TOKEN';
  final String username = 'USERNAME';
  final String password = 'PASSWORD';
  final String rememberMe = 'REMEMBER_ME';
  final String notifications = 'NOTIFICATIONS';
  final String tooManyAttempts = 'TOO_MANY_ATTEMPTS';

  void writeTooManyAttempts(String value) => box.write(tooManyAttempts, value);

  String? getTooManyAttempts() => box.read(tooManyAttempts);

  void writeLocaleCode(String localeCode) =>
      box.write(localeCodeKey, localeCode);

  void writeAuthToken(String authToken) => box.write(this.authToken, authToken);

  String? getAuthToken() => box.read(authToken);

  void writeFcmToken(String fcmToken) => box.write(this.fcmToken, fcmToken);

  String? getFcmToken() => box.read(fcmToken);

  void writeUsername(String username) => box.write(this.username, username);

  String? getUsername() => box.read(username);

  void writePassword(String password) => box.write(this.password, password);

  String? getPassword() => box.read(password);

  void writeRememberMe(bool rememberMe) =>
      box.write(this.rememberMe, rememberMe);

  bool? getRememberMe() => box.read(rememberMe);

  bool? getNotifications() => box.read(notifications);

  void writeNotifications(bool notifications) =>
      box.write(this.notifications, notifications);

  String getFontFamily() {
    String? langCode = readLocaleCode();
    if (langCode == null) {
      return FontFamily.inter;
    }

    if (readLocaleCode()?.compareTo('ar') == 0) {
      return FontFamily.tajawal;
    }
    return FontFamily.inter;
  }

  String getFontFamilyFromCode(langCode) {
    if (langCode == null) {
      return FontFamily.inter;
    }

    if (langCode.compareTo('ar') == 0) {
      return FontFamily.tajawal;
    }
    return FontFamily.inter;
  }

  changeFontFamily() {
    String fontFamily = getFontFamily();
    Get.changeTheme(ThemeData(
      fontFamily: fontFamily,
    ));
    // Get.appUpdate();
  }

  String? readLocaleCode() {
    return box.read(localeCodeKey) ?? 'ar';
  }
}
