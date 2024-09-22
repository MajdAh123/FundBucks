import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/logoAnimation.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/photo_controller.dart';

class PhotoView extends GetView<PhotoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.to.getIsDarkMode
          ? backgroundColorDarkTheme
          : backgroundColorLightTheme,
      floatingActionButton: FloatingActionButton(
        onPressed: controller.downloadImage,
        child: Icon(
          Icons.download,
          color: ThemeController.to.getIsDarkMode
              ? containerColorLightTheme
              : mainColorDarkTheme,
        ),
        backgroundColor: ThemeController.to.getIsDarkMode
            ? bottomBarItemColorDarkTheme
            : mainColor,
      ),
      body: Obx(
        () => Column(
          children: [
            Container(
              height: 90.h,
              color: ThemeController.to.getIsDarkMode
                  ? mainColorDarkTheme
                  : mainColor,
              child: PageHeaderWidget(
                title: 'view_photo'.tr,
                canBack: true,
                hasNotificationIcon: false,
                icon: const SizedBox(),
              ),
            ),
            Expanded(
                child: InteractiveViewer(
              child: controller.getPhotoUrl().isEmpty
                  ? Center(
                      child: LoadingLogoWidget(
                      width: 60,
                    ))
                  : Image.network(
                      controller.getPhotoUrl(),
                    ),
            )),
          ],
        ),
      ),
    );
  }
}
