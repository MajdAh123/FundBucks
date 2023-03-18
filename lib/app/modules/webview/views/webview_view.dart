import 'package:app/app/utils/utils.dart';
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
      backgroundColor: backgroundColor,
      body: Obx(
        () => Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Column(
            children: [
              Container(
                height: 70.h,
                color: mainColor,
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
                          child: SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : WebViewWidget(controller: controller.webviewController),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
