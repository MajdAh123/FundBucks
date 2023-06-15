import 'package:app/app/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

class LanguageController extends GetxController {
  var language = ''.obs;

  void setLanguage(language) => this.language.value = language;
  String getLanguage() => language.value;

  @override
  void onInit() {
    final presistentData = PresistentData();
    setLanguage(presistentData.readLocaleCode());
    print('Lang from controller: ' + presistentData.readLocaleCode()!);

    Get.updateLocale(Locale(getLanguage()));
    // intl.
    initializeDateFormatting();
    super.onInit();
  }
}
