import 'package:app/app/modules/home/controllers/operation_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OperationListWidget extends GetView<OperationController> {
  final String title;
  final double marginTop;
  final bool isDepositList;
  const OperationListWidget({
    Key? key,
    required this.title,
    required this.marginTop,
    this.isDepositList = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: marginTop),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                //fontFamily: FontFamily.inter,
                fontWeight: FontWeight.w600,
                color: ThemeController.to.getIsDarkMode
                    ? containerColorLightTheme
                    : chartTitleColor,
              ),
            ),
            SizedBox(height: 12.h),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(top: 0),
              children: isDepositList
                  ? controller.getDepositsList().isEmpty
                      ? [
                          Center(
                            child: Text(
                              'no_previous_operations'.tr,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ]
                      : controller
                          .getDepositsList()
                          .map(
                            (e) => OperationItemWidget(
                              fullname: controller.homeController
                                      .getUser()
                                      ?.bankName ??
                                  '',
                              // fullname: Functions.fullname(
                              //     controller.homeController
                              //         .getUser()
                              //         ?.firstname,
                              //     controller.homeController
                              //         .getUser()
                              //         ?.lastname),
                              bankAccountNumber: controller.homeController
                                  .getUser()
                                  ?.bankUserId,
                              amount: Functions.getAmountOperation(
                                e.amount ?? 0,
                                e.amountDollar ?? 0,
                                e.currency,
                              ),
                              date: e.fromAdmin!
                                  ? intl.DateFormat(Functions.getDateStyle())
                                      .format(e.createdAt!)
                                      .toString()
                                  : intl.DateFormat(Functions.getDateStyle())
                                      .format(e.approveDate!)
                                      .toString(),
                            ),
                          )
                          .toList()
                  : controller.getWithdrawsList().isEmpty
                      ? [
                          Center(
                            child: Text(
                              'no_previous_operations'.tr,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ]
                      : controller
                          .getWithdrawsList()
                          .map((e) => OperationItemWidget(
                                fullname: controller.homeController
                                        .getUser()
                                        ?.bankName ??
                                    '',
                                // fullname: Functions.fullname(
                                //     controller.homeController
                                //         .getUser()
                                //         ?.firstname,
                                //     controller.homeController
                                //         .getUser()
                                //         ?.lastname),
                                bankAccountNumber: controller.homeController
                                    .getUser()
                                    ?.bankUserId,
                                amount: Functions.getAmountOperation(
                                  e.amount ?? 0,
                                  e.amountDollar ?? 0,
                                  e.currency,
                                ),
                                date: intl.DateFormat(Functions.getDateStyle())
                                    .format(e.createdAt!)
                                    .toString(),
                              ))
                          .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
