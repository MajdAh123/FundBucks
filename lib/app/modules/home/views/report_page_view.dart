import 'package:app/app/modules/home/controllers/report_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/painters/balance_widget_painter.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/logoAnimation.dart';
import 'package:app/app/widgets/page_header_widget.dart';
import 'package:app/app/widgets/report_info_card_widget.dart';
import 'package:app/app/widgets/report_list_widget.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:timezone/standalone.dart' as tz;

import 'account_page_view.dart';

class ReportPageView extends GetView<ReportController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Center(child: LoadingLogoWidget())
          : EasyRefresh(
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
                controller.setTotalDeposits(0);
                controller.setTotalWithdraws(0);
                controller.setStartInvestment(0);
                controller.setEndInvestment(0);
                controller.setInvestmentDifference(0);
                controller.setInvestmentPercent(0);
                controller.setStartDate('');
                controller.setEndDate('');
                controller.toTextEditingController.value.text = '';
                controller.fromTextEditingController.value.text = '';
                controller.getReports();
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
                    PageHeaderWidget(title: 'reports'.tr),
                    const ReportInfoCardWidget(),
                    controller.isLoading.value
                        ? Center(
                            child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(
                            width: 375.w,
                            height: 120.h,
                            margin: EdgeInsets.only(top: 360.h),
                            child: CustomPaint(
                              painter: BalanceWidgetPainter(
                                color: controller.getInvestmentDifference() == 0
                                    ? Colors.grey
                                    : controller.getIfInvestmentPositive()
                                        ? activeTextColor
                                        : secondaryColor,
                              ),
                              child: Stack(
                                children: [
                                  SizedBox(height: 20.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 8.5.h),
                                        child: Text(
                                          Functions.getCurrency(controller
                                                  .homeController
                                                  .getUser()) +
                                              Functions.moneyFormat(controller
                                                          .getInvestmentDifference() <
                                                      0
                                                  ? (controller
                                                              .getInvestmentDifference() *
                                                          -1.0)
                                                      .toString()
                                                  : controller
                                                      .getInvestmentDifference()
                                                      .toString()),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 3.w),
                                      Iconify(
                                        controller.getInvestmentDifference() ==
                                                0
                                            ? Get.locale?.languageCode
                                                        .compareTo('ar') ==
                                                    0
                                                ? Bi.arrow_left_short
                                                : Bi.arrow_right_short
                                            : controller
                                                    .getIfInvestmentPositive()
                                                ? Bi.arrow_up_short
                                                : Bi.arrow_down_short,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    left: 10.h,
                                    bottom: 50.h,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Text(
                                        Get.locale?.languageCode
                                                    .compareTo('ar') ==
                                                0
                                            ? 'end_date'.trParams({
                                                'date': controller
                                                        .getEndDate()
                                                        .isNotEmpty
                                                    ? controller.getDate(
                                                        controller.getEndDate())
                                                    : controller
                                                        .getInitialDateText(
                                                            '00/00/0000'),
                                              })
                                            : 'start_date'.trParams({
                                                'date': controller
                                                        .getStartDate()
                                                        .isNotEmpty
                                                    ? controller.getDate(
                                                        controller
                                                            .getStartDate())
                                                    : controller
                                                        .getInitialDateText(
                                                            '00/00/0000'),
                                              }),
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.h,
                                    bottom: 70.h,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Text(
                                        Get.locale?.languageCode
                                                    .compareTo('ar') ==
                                                0
                                            ? Functions.getCurrency(controller
                                                    .homeController
                                                    .getUser()) +
                                                Functions.moneyFormat(controller
                                                    .getEndInvestment()
                                                    .toString())
                                            : Functions.getCurrency(controller
                                                    .homeController
                                                    .getUser()) +
                                                Functions.moneyFormat(controller
                                                    .getStartInvestment()
                                                    .toString()),
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            color: controller.getTextColor(
                                              Get.locale?.languageCode
                                                          .compareTo('ar') ==
                                                      0
                                                  ? controller
                                                      .getEndInvestment()
                                                  : controller
                                                      .getStartInvestment(),
                                            )),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10.h,
                                    bottom: 50.h,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Text(
                                        Get.locale?.languageCode
                                                    .compareTo('ar') ==
                                                0
                                            ? 'start_date'.trParams({
                                                'date': controller
                                                        .getStartDate()
                                                        .isNotEmpty
                                                    ? controller.getDate(
                                                        controller
                                                            .getStartDate())
                                                    : controller
                                                        .getInitialDateText(
                                                            '00/00/0000'),
                                              })
                                            : 'end_date'.trParams({
                                                'date': controller
                                                        .getEndDate()
                                                        .isNotEmpty
                                                    ? controller.getDate(
                                                        controller.getEndDate())
                                                    : controller
                                                        .getInitialDateText(
                                                            '00/00/0000'),
                                              }),
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 10.h,
                                    bottom: 70.h,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Text(
                                        Get.locale?.languageCode
                                                    .compareTo('ar') ==
                                                0
                                            ? Functions.getCurrency(controller
                                                    .homeController
                                                    .getUser()) +
                                                Functions.moneyFormat(controller
                                                    .getStartInvestment()
                                                    .toString())
                                            : Functions.getCurrency(controller
                                                    .homeController
                                                    .getUser()) +
                                                Functions.moneyFormat(controller
                                                    .getEndInvestment()
                                                    .toString()),
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: controller.getTextColor(
                                            Get.locale?.languageCode
                                                        .compareTo('ar') ==
                                                    0
                                                ? controller
                                                    .getStartInvestment()
                                                : controller.getEndInvestment(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.only(top: 315.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '%' +
                                Functions.formatPercent(
                                    controller.getInvestmentPercent() < 0
                                        ? (controller.getInvestmentPercent() *
                                            -1.0)
                                        : controller.getInvestmentPercent()),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: controller.getInvestmentDifference() == 0
                                  ? Colors.grey
                                  : controller.getIfInvestmentPositive()
                                      ? activeTextColor
                                      : secondaryColor,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Iconify(
                            controller.getInvestmentDifference() == 0
                                ? Get.locale?.languageCode.compareTo('ar') == 0
                                    ? Bi.arrow_left_short
                                    : Bi.arrow_right_short
                                : controller.getIfInvestmentPositive()
                                    ? Bi.arrow_up_short
                                    : Bi.arrow_down_short,
                            color: controller.getInvestmentDifference() == 0
                                ? Colors.grey
                                : controller.getIfInvestmentPositive()
                                    ? activeTextColor
                                    : secondaryColor,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.only(left: 17.w, right: 16.w, top: 465.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'select_time_period'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: ThemeController.to.getIsDarkMode
                                  ? unselectedBottomBarItemColorDarkTheme
                                  : unselectedBottomBarItemColorLightTheme,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${"from".tr}:',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
                                ),
                              ),
                              SizedBox(height: 7.h),
                              Obx(
                                () => Theme(
                                  data: ThemeController.to.getIsDarkMode
                                      ? ThemeData.dark(useMaterial3: true)
                                          .copyWith(
                                              colorScheme: ColorScheme.fromSeed(
                                                  brightness: Brightness.dark,
                                                  seedColor: Colors.blue))
                                      : ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.fromSeed(
                                              seedColor: Colors.blue)),
                                  child: DateTimePicker(
                                    controller: controller
                                        .fromTextEditingController.value,
                                    autovalidate: false,
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return 'required_field'.trParams({
                                          'name': 'start_date'.trParams({
                                            'date': '',
                                          }),
                                        });
                                      }
                                      return null;
                                    },
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    dateLabelText: 'Date',
                                    decoration: InputDecoration(
                                      suffixIcon: Padding(
                                        padding:
                                            marginHorizontalBasedOnLanguage(
                                                11.w),
                                        child: Iconify(
                                          Ic.twotone_date_range,
                                          size: 27,
                                          color:
                                              ThemeController.to.getIsDarkMode
                                                  ? bottomBarItemColorDarkTheme
                                                  : mainColor,
                                        ),
                                      ),
                                      suffixIconConstraints: BoxConstraints(
                                          maxWidth: 27.w, maxHeight: 27.h),
                                      fillColor:
                                          ThemeController.to.getIsDarkMode
                                              ? containerColorDarkTheme
                                              : containerColorLightTheme,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                          color: strokeColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color:
                                              ThemeController.to.getIsDarkMode
                                                  ? greyColor.withOpacity(.39)
                                                  : strokeColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      errorText:
                                          controller.fromDateError.value.isEmpty
                                              ? null
                                              : controller.fromDateError.value,
                                    ),
                                    onChanged: (val) =>
                                        controller.validateFromDate(),
                                    onSaved: (val) => print(val),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: ThemeController.to.getIsDarkMode
                                          ? unselectedBottomBarItemColorDarkTheme
                                          : unselectedBottomBarItemColorLightTheme,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${"to".tr}:',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
                                ),
                              ),
                              SizedBox(height: 7.h),
                              Obx(
                                () => Theme(
                                  data: ThemeController.to.getIsDarkMode
                                      ? ThemeData.dark(useMaterial3: true)
                                          .copyWith(
                                              colorScheme: ColorScheme.fromSeed(
                                                  brightness: Brightness.dark,
                                                  seedColor: Colors.blue))
                                      : ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.fromSeed(
                                              seedColor: Colors.blue)),
                                  child: DateTimePicker(
                                    controller: controller
                                        .toTextEditingController.value,
                                    autovalidate: false,
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return 'required_field'.trParams({
                                          'name': 'end_date'.trParams({
                                            'date': '',
                                          }),
                                        });
                                      }
                                      if (value != null) {
                                        if (controller.fromTextEditingController
                                            .value.text.isNotEmpty) {
                                          DateTime from = DateTime.parse(
                                              controller
                                                  .fromTextEditingController
                                                  .value
                                                  .text);
                                          DateTime to = DateTime.parse(value);
                                          if (!to.isAfter(from)) {
                                            return 'start_date_before_end_date'
                                                .tr;
                                          }
                                        }
                                      }
                                      return null;
                                    },
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(
                                      tz.TZDateTime.now(kuwaitTimezoneLocation)
                                          .year,
                                      tz.TZDateTime.now(kuwaitTimezoneLocation)
                                          .month,
                                      tz.TZDateTime.now(kuwaitTimezoneLocation)
                                          .day,
                                    ),
                                    dateLabelText: 'Date',
                                    decoration: InputDecoration(
                                      suffixIcon: Padding(
                                        padding:
                                            marginHorizontalBasedOnLanguage(
                                                11.w),
                                        child: Iconify(
                                          Ic.twotone_date_range,
                                          size: 27,
                                          color:
                                              ThemeController.to.getIsDarkMode
                                                  ? bottomBarItemColorDarkTheme
                                                  : mainColor,
                                        ),
                                      ),
                                      suffixIconConstraints: BoxConstraints(
                                          maxWidth: 27.w, maxHeight: 27.h),
                                      fillColor:
                                          ThemeController.to.getIsDarkMode
                                              ? containerColorDarkTheme
                                              : containerColorLightTheme,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                          color: strokeColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color:
                                              ThemeController.to.getIsDarkMode
                                                  ? greyColor.withOpacity(.39)
                                                  : strokeColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      errorText:
                                          controller.toDateError.value.isEmpty
                                              ? null
                                              : controller.toDateError.value,
                                    ),
                                    onChanged: (val) =>
                                        controller.validateToDate(),
                                    onSaved: (val) => print(val),
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: ThemeController.to.getIsDarkMode
                                          ? unselectedBottomBarItemColorDarkTheme
                                          : unselectedBottomBarItemColorLightTheme,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          Container(
                            margin: EdgeInsets.only(
                                left: 10.w, right: 10.w, bottom: 10.h),
                            child: TextButton(
                              onPressed: controller.onSearchButtonClick,
                              style: TextButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor:
                                    ThemeController.to.getIsDarkMode
                                        ? mainColorDarkTheme
                                        : mainColor,
                              ),
                              child: Text(
                                "search".tr,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          ReportListWidget(
                            title: 'investment_reports'.tr,
                            marginTop: 20.h,
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
