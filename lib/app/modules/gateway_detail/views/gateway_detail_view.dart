import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/logoAnimation.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/gateway_detail_controller.dart';

class GatewayDetailView extends GetView<GatewayDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.to.getIsDarkMode
          ? backgroundColorDarkTheme
          : backgroundColorLightTheme,
      body: Obx(
        () => Stack(
          // mainAxisSize: MainAxisSize.min,
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 5.w),
                  child: controller.getIsLoading()
                      ? Center(
                          child: LoadingLogoWidget(
                          width: 60,
                        ))
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 60.h),
                            Text(
                              '${'instructions'.tr}:',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ThemeController.to.getIsDarkMode
                                    ? containerColorDarkTheme
                                    : containerColorLightTheme,
                              ),
                              child: HtmlWidget(
                                controller.getData(),
                                factoryBuilder: () => MyHtmlWidgetFactory(),
                                onTapUrl: (url) async {
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    return await launchUrl(Uri.parse(url));
                                  } else {
                                    return false;
                                    // throw 'Could not launch $url';
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 15.h),
                          ],
                        ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: controller.getIsLoading()
                  ? Center(
                      child: LoadingLogoWidget(
                      width: 60,
                    ))
                  : SizedBox.shrink(),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 90.h,
                color: ThemeController.to.getIsDarkMode
                    ? mainColorDarkTheme
                    : mainColor,
                child: PageHeaderWidget(
                  title: 'gateway'.tr,
                  canBack: true,
                  hasNotificationIcon: false,
                  icon: const SizedBox(),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(right: 17.w, left: 16.w, bottom: 10.h),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // primary: mainColor,
                    backgroundColor: ThemeController.to.getIsDarkMode
                        ? mainColorDarkTheme
                        : mainColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'close'.tr,
                        style: TextStyle(
                          //fontFamily: FontFamily.inter,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}

class MyHtmlWidgetFactory extends WidgetFactory {
  @override
  Widget buildGestureDetector_(
    BuildMetadata meta,
    Widget child,
    GestureTapCallback onTap,
  ) {
    return GestureDetector(
      child: child,
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
    );
  }

  @override
  Future<bool> onTapUrl(String url) {
    if (url.toLowerCase().endsWith('.pdf')) {
      // Download the PDF file using flutter_downloader

      Functions.downloadFile(url, true);
      return Future.value(true);
    } else {
      // Launch the URL in the default web browser
      return launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
