import 'package:app/app/modules/home/controllers/account_controller.dart';
import 'package:app/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MutliTimeChartChoiceWidget extends GetView<AccountController> {
  const MutliTimeChartChoiceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(
        //   color: mainColor,
        // ),
      ),
      child: Obx(
        () => Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () => controller.setChoice(0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Get.locale?.languageCode.compareTo('ar') == 1
                        ? Radius.circular(5.r)
                        : Radius.circular(0.r),
                    bottomLeft: Get.locale?.languageCode.compareTo('ar') == 1
                        ? Radius.circular(5.r)
                        : Radius.circular(0.r),
                    topRight: Get.locale?.languageCode.compareTo('ar') == 1
                        ? Radius.circular(0.r)
                        : Radius.circular(5.r),
                    bottomRight: Get.locale?.languageCode.compareTo('ar') == 1
                        ? Radius.circular(0.r)
                        : Radius.circular(5.r),
                  ),
                  // color: controller.getChoice() == 0 ? mainColor : Colors.white,
                ),
                child: Text(
                  'days'.tr,
                  style: TextStyle(
                    fontSize: 11.sp,
                    // fontWeight: controller.getChoice() == 0
                    //     ? FontWeight.w400
                    //     : FontWeight.w800,
                    color: controller.getChoice() == 0
                        ? mainColor
                        : unselectedBottomBarItemColor,
                    // color:
                    //     controller.getChoice() != 0 ? mainColor : Colors.white,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.setChoice(1),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                // decoration: BoxDecoration(
                //   color: controller.getChoice() == 1 ? mainColor : Colors.white,
                // ),
                child: Text(
                  'months'.tr,
                  style: TextStyle(
                    fontSize: 11.sp,
                    // fontWeight: controller.getChoice() == 1
                    //     ? FontWeight.w400
                    //     : FontWeight.w700,
                    color: controller.getChoice() == 1
                        ? mainColor
                        : unselectedBottomBarItemColor,
                    // color:
                    //     controller.getChoice() != 1 ? mainColor : Colors.white,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.setChoice(2),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Get.locale?.languageCode.compareTo('ar') == 1
                        ? Radius.circular(0.r)
                        : Radius.circular(5.r),
                    bottomLeft: Get.locale?.languageCode.compareTo('ar') == 1
                        ? Radius.circular(0.r)
                        : Radius.circular(5.r),
                    topRight: Get.locale?.languageCode.compareTo('ar') == 1
                        ? Radius.circular(5.r)
                        : Radius.circular(0.r),
                    bottomRight: Get.locale?.languageCode.compareTo('ar') == 1
                        ? Radius.circular(5.r)
                        : Radius.circular(0.r),
                  ),
                  // color: controller.getChoice() == 2 ? mainColor : Colors.white,
                ),
                child: Text(
                  'years'.tr,
                  style: TextStyle(
                    fontSize: 11.sp,
                    // fontWeight: controller.getChoice() == 2
                    //     ? FontWeight.w400
                    //     : FontWeight.w700,
                    color: controller.getChoice() == 2
                        ? mainColor
                        : unselectedBottomBarItemColor,
                    // color:
                    //     controller.getChoice() != 2 ? mainColor : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
