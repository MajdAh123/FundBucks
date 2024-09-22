import 'package:app/app/modules/home/controllers/operation_controller.dart';
import 'package:app/app/modules/home/views/account_page_view.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/logoAnimation.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class OperationPageView extends GetView<OperationController> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: ClassicHeader(
        dragText: 'pull_to_refresh'.tr,
        armedText: 'release_ready'.tr,
        messageText: 'last_updated_at'.tr,
        readyText: 'refreshing'.tr,
      ),
      footer: MyFooter(
        triggerOffset: 1,
        clamping: false,
      ),
      onRefresh: () {
        controller.clearAllForms();
        controller.getOperations();
      },
      onLoad: () async {},
      child: SingleChildScrollView(
        controller: controller.scrollController,
        child: Stack(
          children: [
            Container(
              height: 110.h,
              color: ThemeController.to.getIsDarkMode
                  ? mainColorDarkTheme
                  : mainColor,
            ),
            PageHeaderWidget(title: 'transfer'.tr),
            const OperationButtonDisplayWidget(),
          ],
        ),
      ),
    );
  }
}

class OperationButtonDisplayWidget extends GetView<OperationController> {
  const OperationButtonDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 90.h),
        child: Column(
          children: [
            Container(
              width: 325.w,
              height: 56.h,
              margin: EdgeInsets.only(left: 25.w, right: 25.w),
              padding: EdgeInsets.only(left: 3.w, right: 3.w),
              decoration: BoxDecoration(
                color: ThemeController.to.getIsDarkMode
                    ? containerColorDarkTheme
                    : containerColorLightTheme,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.setIndex(controller.getIndex() == 0 ? 1 : 0);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                        width: 156.5.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: controller.getIndex() == 0
                              ? (ThemeController.to.getIsDarkMode
                                  ? secondaryColorDarkTheme
                                  : secondaryColor)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'withdraw_request'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: controller.getIndex() == 0
                                  ? Colors.white
                                  : (ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.setIndex(controller.getIndex() == 0 ? 1 : 0);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeInOut,
                        width: 156.5.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: controller.getIndex() == 1
                              ? (ThemeController.to.getIsDarkMode
                                  ? mainColorDarkTheme
                                  : mainColor)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'deposit_request'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: controller.getIndex() == 1
                                  ? Colors.white
                                  : (ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
              child: Column(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 800),
                    child: controller.getIndex() == 0
                        ? controller.getIsLoading()
                            ? Center(
                                child: LoadingLogoWidget(),
                              )
                            : WithdrawFormWidget()
                        : controller.getIsLoading()
                            ? Center(
                                child: LoadingLogoWidget(),
                              )
                            : DepositFormWidget(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
