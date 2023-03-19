import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeaderNotificationWidget extends GetView<HomeController> {
  const HeaderNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 50.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            NotificationIndicatorWidget(
              hasNotification: controller.getIsThereNotification(),
            ),
            SizedBox(width: 17.w),
          ],
        ),
      ),
    );
  }
}
