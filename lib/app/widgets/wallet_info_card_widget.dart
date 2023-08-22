import 'package:app/app/modules/home/controllers/account_controller.dart';
import 'package:app/app/modules/home/views/account_page_view.dart';
import 'package:app/app/modules/home/views/home_view.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/painters/painters.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';

class WalletInfoCardWidget extends GetView<AccountController> {
  const WalletInfoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 170.h,
        width: 314.w,
        margin: EdgeInsets.only(top: 125.h, left: 30.w, right: 31.w),
        child: CustomPaint(
          painter: CardWidgetPainter(
            percent: 0.91,
            borderRadius: 12.r,
            color: ThemeController.to.getIsDarkMode
                ? containerColorDarkTheme
                : containerColorLightTheme,
          ),
          willChange: true,
          child: Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Column(
              children: [
                Container(
                  width: 45.w,
                  height: 20.h,
                  margin: EdgeInsets.only(bottom: 10.h),
                  decoration: BoxDecoration(
                    color: controller.homeController
                                .getUser()!
                                .type
                                ?.compareTo('test') ==
                            0
                        ? secondaryColor
                        : controller.homeController.getUser()!.isBankVer == 0
                            ? inActiveBackgroundColor
                            : activeBackgroundColor,
                    borderRadius: BorderRadius.circular(8.5.h),
                  ),
                  child: Center(
                    child: Text(
                      controller.homeController
                                  .getUser()!
                                  .type
                                  ?.compareTo('test') ==
                              0
                          ? 'test_mode'.tr
                          : controller.homeController.getUser()!.isBankVer == 0
                              ? 'inactive'.tr
                              : 'active'.tr,
                      style: TextStyle(
                        fontSize: 10.sp,
                        //fontFamily: FontFamily.inter,
                        fontWeight: FontWeight.w400,
                        color: controller.homeController
                                    .getUser()!
                                    .type
                                    ?.compareTo('test') ==
                                0
                            ? Colors.white
                            : controller.homeController.getUser()!.isBankVer ==
                                    0
                                ? inActiveTextColor
                                : activeTextColor,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ColumnCardWidget(
                      title: 'current_value'.tr,
                      value:
                          '${Functions.getCurrency(controller.homeController.getUser())}${Functions.moneyFormat(double.parse(controller.homeController.getUser()!.currentValue!) != 0 ? controller.homeController.getUser()!.currentValue! : controller.homeController.getUser()!.balance!)}',
                      // maxWidth: 150.w,
                      isCenter: true,
                      textValueSize: 17.sp,
                      color: ThemeController.to.getIsDarkMode
                          ? Colors.white
                          : mainColor,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
                  // margin: EdgeInsets.only(left: 1.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ColumnCardWidget(
                        title: 'income_value'.tr,
                        textValueSize: 16.sp,
                        homePageSpace: true,
                        value:
                            '${Functions.getCurrency(controller.homeController.getUser(), null, false)}${Functions.moneyFormat(double.parse(controller.homeController.getUser()!.returnValue!) < 0 ? (double.parse(controller.homeController.getUser()!.returnValue!) * -1).toString() : controller.homeController.getUser()!.returnValue!)}',
                        beforeValue:
                            !(Get.locale?.languageCode.compareTo('ar') == 0)
                                ? Iconify(
                                    Bi.arrow_up_short,
                                    size: 16.h,
                                    color: controller.getAmountColor(
                                        double.parse(controller.homeController
                                            .getUser()!
                                            .returnValue!)),
                                  )
                                : null,
                        afterValue:
                            (Get.locale?.languageCode.compareTo('ar') == 0)
                                ? Iconify(
                                    double.parse(controller.homeController
                                                .getUser()!
                                                .returnValue!) >=
                                            0
                                        ? Bi.arrow_up_short
                                        : Bi.arrow_down_short,
                                    size: 16.h,
                                    color: controller.getAmountColor(
                                        double.parse(controller.homeController
                                            .getUser()!
                                            .returnValue!)),
                                  )
                                : null,
                        color: controller.getAmountColor(double.parse(
                            controller.homeController.getUser()!.returnValue!)),
                        isRight: true,
                      ),
                      // SizedBox(width: 44.w),
                      ColumnCardWidget(
                        title: 'percent_of_change'.tr,
                        textValueSize: 16.sp,
                        value:
                            '%${double.parse(controller.homeController.getUser()!.returnPercent!) == 0 ? '00.00' : (double.parse(controller.homeController.getUser()!.returnPercent!) < 0 ? (double.parse(controller.homeController.getUser()!.returnPercent!) * -1).toString() : controller.homeController.getUser()!.returnPercent!)}',
                        beforeValue:
                            (Get.locale?.languageCode.compareTo('ar') == 0)
                                ? Iconify(
                                    double.parse(controller.homeController
                                                .getUser()!
                                                .returnPercent!) >=
                                            0
                                        ? Bi.arrow_up_short
                                        : Bi.arrow_down_short,
                                    size: 16.h,
                                    color: controller.getAmountColor(
                                        double.parse(controller.homeController
                                            .getUser()!
                                            .returnPercent!)),
                                  )
                                : null,
                        afterValue:
                            !(Get.locale?.languageCode.compareTo('ar') == 0)
                                ? Iconify(
                                    Bi.arrow_up_short,
                                    size: 16.h,
                                    color: controller.getAmountColor(
                                        double.parse(controller.homeController
                                            .getUser()!
                                            .returnPercent!)),
                                  )
                                : null,
                        color: controller.getAmountColor(double.parse(controller
                            .homeController
                            .getUser()!
                            .returnPercent!)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
