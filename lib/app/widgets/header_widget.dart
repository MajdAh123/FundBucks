import 'package:app/app/modules/home/controllers/account_controller.dart';
import 'package:app/app/utils/functions.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HeaderWidget extends GetView<AccountController> {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 375.w,
                  margin: EdgeInsets.only(top: 25.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeaderColumnWidget(
                        title: '${"capital".tr}:',
                        value:
                            '\$${Functions.moneyFormat(controller.homeController.getUser()!.balance ?? '')}',
                        isRight: false,
                      ),
                      SizedBox(width: 10.w),
                      controller.homeController.getUser()!.avatar == null
                          ? SizedBox()
                          : CircleAvatar(
                              radius: 30.r,
                              backgroundImage: NetworkImage(
                                Functions.getUserAvatar(
                                  controller.homeController.getUser()!.avatar ??
                                      '',
                                ),
                              ),
                            ),
                      SizedBox(width: 10.w),
                      HeaderColumnWidget(
                        title: '${"plan_new".tr}:',
                        value: Functions.getTranslate(
                            enValue: controller.homeController
                                    .getUser()!
                                    .plan
                                    ?.enName! ??
                                '',
                            arValue: controller.homeController
                                    .getUser()!
                                    .plan
                                    ?.name! ??
                                ''),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(width: 22.w),
            ],
          ),
        ],
      ),
    );
  }
}
