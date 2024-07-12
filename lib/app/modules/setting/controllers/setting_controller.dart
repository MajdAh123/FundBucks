import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/home/controllers/profile_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:app/app/data/data.dart';
import 'package:app/app/modules/lanuage_controller.dart';
import 'package:app/app/modules/setting/providers/setting_provider.dart';

class SettingController extends GetxController {
  final SettingProvider settingProvider;
  SettingController({
    required this.settingProvider,
  });
  final presistentData = PresistentData();

  final activateNotifications = true.obs;

  var isLoading = false.obs;

  void setIsLoading(value) => isLoading.value = value;
  bool getIsLoading() => isLoading.value;

  void setActivateNotification() =>
      activateNotifications.value = !activateNotifications.value;

  bool getActivateNotification() => activateNotifications.value;

  void changeLanguage(String? languageCode) {
    if (languageCode == null) {
      return;
    }

    if (Get.locale?.languageCode.compareTo('ar') == 0 &&
        languageCode.compareTo('العربية') == 0) {
    } else {
      String lang = '';
      languageCode.compareTo('العربية') == 0 ? lang = 'ar' : lang = 'en';
      final languageController = Get.find<LanguageController>();
      languageController.setLanguage(languageCode);
      presistentData.writeLocaleCode(lang);
      Get.updateLocale(Locale(lang));
    }
  }

  void changeTheme(bool? themeMode) {
    if (themeMode == null) {
      return;
    }

    final themeController = Get.find<ThemeController>();
    themeController.toggleTheme();

    Get.forceAppUpdate();
  }

  void initNotifications() {
    if (presistentData.getNotifications() == null) {
      presistentData.writeNotifications(true);
      activateNotifications.value = true;
      return;
    }
    if (presistentData.getNotifications()!) {
      activateNotifications.value = true;
      return;
    }
    activateNotifications.value = false;
  }

  void updateNotifications() async {
    setIsLoading(true);
    final fcm = presistentData.getFcmToken();
    final FormData _formData = FormData({
      'fcm': getActivateNotification() ? fcm : null,
    });
    await settingProvider.setNotification(_formData).then((value) {
      setIsLoading(false);
      if (value.statusCode == 200) {
        print('success');
        presistentData.writeNotifications(getActivateNotification());
        print(getActivateNotification());
      }
    });
  }

  void changeNotificationsStatus() {
    setActivateNotification();
    updateNotifications();
  }

  @override
  void onInit() {
    initNotifications();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
