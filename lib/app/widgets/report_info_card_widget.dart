import 'package:app/app/modules/home/controllers/report_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/painters/painters.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ReportInfoCardWidget extends GetView<ReportController> {
  const ReportInfoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: 314.w,
      margin: EdgeInsets.only(top: 90.h, left: 30.w, right: 31.w),
      child: CustomPaint(
        painter: CardWidgetPainter(
          percent: 0.91,
          borderRadius: 12,
          color: ThemeController.to.getIsDarkMode
              ? containerColorDarkTheme
              : containerColorLightTheme,
        ),
        willChange: true,
        child: Container(
          margin: EdgeInsets.only(top: 10.h),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'operations'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      //fontFamily: FontFamily.inter,
                      fontWeight: FontWeight.w600,
                      color: ThemeController.to.getIsDarkMode
                          ? unselectedBottomBarItemColorDarkTheme
                          : chartTitleColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Container(
                // margin: EdgeInsets.only(left: 1.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ColumnCardWidget(
                      title: 'deposits'.tr,
                      value: Functions.getCurrency(
                              controller.homeController.getUser()) +
                          Functions.moneyFormat(
                              controller.getTotalDeposits().toString()),
                      color: controller.getTotalDeposits() != 0
                          ? activeTextColor
                          : (ThemeController.to.getIsDarkMode
                              ? unselectedBottomBarItemColorDarkTheme
                              : unselectedBottomBarItemColorLightTheme),
                      isRight: true,
                    ),
                    ColumnCardWidget(
                      title: 'withdraws'.tr,
                      value: Functions.getCurrency(
                              controller.homeController.getUser()) +
                          Functions.moneyFormat(
                              controller.getTotalWithdraws().toString()),
                      color: controller.getTotalWithdraws() != 0
                          ? secondaryColor
                          : (ThemeController.to.getIsDarkMode
                              ? unselectedBottomBarItemColorDarkTheme
                              : unselectedBottomBarItemColorLightTheme),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
