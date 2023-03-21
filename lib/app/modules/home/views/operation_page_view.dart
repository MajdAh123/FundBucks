import 'package:app/app/modules/home/controllers/operation_controller.dart';
import 'package:app/app/modules/home/views/account_page_view.dart';
import 'package:app/app/utils/utils.dart';
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
        child: Stack(
          children: [
            Container(
              height: 110.h,
              color: mainColor,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller
                            .setIndex(controller.getIndex() == 0 ? 1 : 0);
                        // controller.operationController.reset();
                        // controller.operationController.forward();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 156.5.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: controller.getIndex() == 0
                              ? secondaryColor
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'withdraw_request'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              //fontFamily: FontFamily.inter,
                              fontWeight: FontWeight.w500,
                              color: controller.getIndex() == 0
                                  ? Colors.white
                                  : unselectedBottomBarItemColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller
                            .setIndex(controller.getIndex() == 0 ? 1 : 0);
                        // controller.operationController.reset();
                        // controller.operationController.forward();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 156.5.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: controller.getIndex() == 1
                              ? mainColor
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'deposit_request'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              //fontFamily: FontFamily.inter,
                              fontWeight: FontWeight.w500,
                              color: controller.getIndex() == 1
                                  ? Colors.white
                                  : unselectedBottomBarItemColor,
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
                  if (controller.getIndex() == 0) ...[
                    controller.getIsLoading()
                        ? Center(
                            child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : WithdrawFormWidget(),
                  ] else ...[
                    controller.getIsLoading()
                        ? Center(
                            child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : DepositFormWidget(),
                  ],
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
