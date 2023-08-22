import 'package:app/app/modules/home/controllers/contact_controller.dart';
import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/painters/painters.dart';
import 'package:app/app/utils/colors.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/la.dart';

class StretchedBottomNavigationBar extends GetView<HomeController> {
  StretchedBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 65.h,
        child: CustomPaint(
          painter: StretchedBottomNavigationBarPainter(
            color: ThemeController.to.getIsDarkMode
                ? containerColorDarkTheme
                : containerColorLightTheme,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StretchedBottomNavigationBarItem(
                title: 'account'.tr,
                isHome: false,
                icon: Carbon.inventory_management,
                index: 0,
              ),
              StretchedBottomNavigationBarItem(
                title: 'reports'.tr,
                isHome: false,
                icon: Carbon.chart_cluster_bar,
                index: 1,
              ),
              StretchedBottomNavigationBarItem(
                title: 'transfer'.tr,
                isHome: false,
                icon: Carbon.repeat,
                index: 2,
                isSelected: controller.getIndex() == 2,
              ),
              StretchedBottomNavigationBarItem(
                title: 'contact_us'.tr,
                isHome: false,
                icon: Carbon.email_new,
                index: 3,
                isNotification:
                    Get.find<ContactController>().checkIfTheresANewMessage(),
              ),
              StretchedBottomNavigationBarItem(
                title: 'profile'.tr,
                isHome: false,
                icon: La.user,
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
