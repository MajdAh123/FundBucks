import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          ThemeController.to.getIsDarkMode ? mainColorDarkTheme : mainColor,
      body: Center(
        child: Assets.images.png.splashUpdated.image(
          width: 279.w,
        ),
      ),
    );
  }
}
