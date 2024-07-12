import 'package:app/app/modules/home/controllers/report_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class ReportListWidget extends GetView<ReportController> {
  final String title;
  final double marginTop;
  const ReportListWidget({
    Key? key,
    required this.title,
    required this.marginTop,
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
            SizedBox(height: controller.getReportList().isEmpty ? 12.h : 22.h),
            ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top: 0),
                children: controller.getReportList().isEmpty
                    ? [
                        Center(
                          child: Text(
                            'no_investment_reports'.tr,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: ThemeController.to.getIsDarkMode
                                  ? unselectedBottomBarItemColorDarkTheme
                                  : unselectedBottomBarItemColorLightTheme,
                            ),
                          ),
                        ),
                      ]
                    : controller
                        .getReportList()
                        .map((e) => ReportItemWidget(
                              icon: controller
                                  .getIcon(e.returnPercent?.toDouble() ?? 0),
                              notes: e.notes ?? '',
                              currency: Functions.getCurrency(
                                  controller.homeController.getUser()),
                              amount: e.balance?.toDouble() ?? 0,
                              totalAmount: e.totalValue?.toDouble() ?? 0,
                              returnPercent: e.returnPercent?.toDouble() ?? 0,
                              returnValue: e.returnValue?.toDouble() ?? 0,
                              from: 'start_date'.trParams({
                                'date':
                                    intl.DateFormat(Functions.getDateStyle())
                                        .format(e.from!)
                                        .toString()
                              }),
                              to: 'end_date'.trParams({
                                'date':
                                    intl.DateFormat(Functions.getDateStyle())
                                        .format(e.to!)
                                        .toString()
                              }),
                            ))
                        .toList()),
            SizedBox(height: controller.getReportList().isEmpty ? 20.h : 5.h),
          ],
        ),
      ),
    );
  }
}

// intl.DateFormat('yyyy/MM/dd')
// .format(e.approveDate!)
// .toString(),
