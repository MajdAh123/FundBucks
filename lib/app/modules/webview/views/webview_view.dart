import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/logoAnimation.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/webview_controller.dart';

class WebviewView extends GetView<WebviewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.to.getIsDarkMode
          ? backgroundColorDarkTheme
          : backgroundColorLightTheme,
      body: Obx(
        () => Column(
          children: [
            Container(
              height: 90.h,
              color: ThemeController.to.getIsDarkMode
                  ? mainColorDarkTheme
                  : mainColor,
              child: PageHeaderWidget(
                title: controller.getPageTitle(),
                canBack: true,
                hasNotificationIcon: false,
                icon: const SizedBox(),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                child: controller.getIsLoading() ||
                        controller.checkIfPageIsLoading()
                    ? Center(
                        child: LoadingLogoWidget(
                        width: 60,
                      ))
                    : WebViewWidget(controller: controller.webviewController),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
