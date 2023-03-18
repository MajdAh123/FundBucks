import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/support_card_controller.dart';

class SupportCardView extends GetView<SupportCardController> {
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
                  title: 'faq'.tr,
                  canBack: true,
                  hasNotificationIcon: false,
                  icon: const SizedBox(),
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                child: controller.getIsLoading()
                    ? ShimmerListViewWidget()
                    : controller.checkIfSupportCardListIsEmpty()
                        ? Center(
                            child: Text(
                              'no_faq_found'.tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : ListView(
                            shrinkWrap: true,
                            children: [
                              SupportCardWidget(),
                            ],
                          ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
