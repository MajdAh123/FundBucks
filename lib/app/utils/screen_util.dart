import 'package:flutter/material.dart';
import 'package:get/get.dart';

EdgeInsets marginHorizontalBasedOnLanguage(double size) {
  return EdgeInsets.only(
      right: Get.locale?.languageCode.compareTo('ar') == 0 ? 0 : size,
      left: Get.locale?.languageCode.compareTo('ar') == 0 ? size : 0);
}

Widget sizedBoxHorizontal(double size) {
  return Get.locale?.languageCode.compareTo('ar') == 0
      ? const SizedBox.shrink()
      : SizedBox(width: size);
}
