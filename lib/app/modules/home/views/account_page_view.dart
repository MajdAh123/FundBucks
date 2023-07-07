import 'package:app/app/modules/home/controllers/account_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/painters/painters.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:timezone/standalone.dart' as tz;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccountPageView extends GetView<AccountController> {
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
        controller.getStocksApi();
        controller.getHomePageData(controller.choice.value.toString());
        controller.homeController.getIsThereNewNotification();
        controller.homeController.getUserApi();
      },
      onLoad: () async {},
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 208.h,
              color: ThemeController.to.getIsDarkMode
                  ? mainColorDarkTheme
                  : mainColor,
            ),
            const HeaderWidget(),
            const Align(
              alignment: Alignment.topRight,
              child: HeaderNotificationWidget(),
            ),
            SizedBox(height: 38.h),
            const WalletInfoCardWidget(),
            // SizedBox(height: 15.h),
            const StockWatcherWidget(),
            Container(
              width: 342.w,
              // height: 210.h,
              margin: EdgeInsets.only(top: 440.h, left: 17.w, right: 16.w),
              padding: EdgeInsets.only(top: 11.h, left: 12.w, right: 12.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ThemeController.to.getIsDarkMode
                    ? containerColorDarkTheme
                    : containerColorLightTheme,
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'investment_comparing_time_period'.tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            //fontFamily: FontFamily.inter,
                            fontWeight: FontWeight.w600,
                            color: ThemeController.to.getIsDarkMode
                                ? containerColorLightTheme
                                : chartTitleColor,
                          ),
                        ),
                        // Spacer(),
                        controller.getIsLoadingChart()
                            ? SizedBox.shrink()
                            : Expanded(
                                child: MutliTimeChartChoiceWidget(),
                              ),
                      ],
                    ),
                    SizedBox(height: 29.h),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: controller.getIsLoadingChart()
                          ? Center(
                              child: Container(
                                width: 25.w,
                                height: 25.w,
                                margin: EdgeInsets.symmetric(vertical: 50.h),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : InvestmentChangesChart(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 342.w,
              // height: 135.h,
              margin: EdgeInsets.only(
                  top: 670.h, left: 17.w, right: 16.w, bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'assets_details'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      //fontFamily: FontFamily.inter,
                      fontWeight: FontWeight.w600,
                      color: ThemeController.to.getIsDarkMode
                          ? containerColorLightTheme
                          : chartTitleColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GetBuilder<AccountController>(
                    init: controller,
                    builder: (context) {
                      return SizedBox(
                        width: 342.w,
                        // height: 100,
                        child: CustomPaint(
                          painter: AssetsWidgetPainter(
                            list: Get.locale?.languageCode.compareTo('ar') == 0
                                ? controller.getWallets().reversed.toList()
                                : controller.getWallets(),
                            currency: Functions.getCurrency(
                                controller.homeController.getUser()),
                          ),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 340.w,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 40.h),
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 8.w,
                                    runSpacing: 2.h,
                                    runAlignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    alignment: WrapAlignment.spaceBetween,
                                    children: [
                                      ...controller.getWallets().map(
                                            (e) => AssetCircleWidget(
                                              color: e.color,
                                              name: e.name,
                                            ),
                                          ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 340.w,
                                child: Wrap(
                                  spacing: 6.w,
                                  runSpacing: 8.h,
                                  runAlignment: WrapAlignment.center,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.spaceBetween,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ...controller
                                        .getWallets()
                                        .map((e) => AssetValuePercentWidget(
                                              model: e,
                                              currency: Functions.getCurrency(
                                                controller.homeController
                                                    .getUser(),
                                                null,
                                                false,
                                              ),
                                            )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InvestmentChangesChart extends GetView<AccountController> {
  const InvestmentChangesChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Container(
          width: 375.w,
          height: 135.h,
          padding: EdgeInsets.only(right: 5.w),
          child: LineChart(
            mainData(),
          ),
        ),
      ),
    );
  }

  // Widget leftTitleWidgets(double value, TitleMeta meta) {
  //   final style = TextStyle(
  //     color: Color(0xff67727d),
  //     fontWeight: FontWeight.w400,
  //     fontSize: 10.sp,
  //   );
  //   String text;

  //   return Text(text, style: style, textAlign: TextAlign.right);
  // }

  LineChartData mainData() {
    return LineChartData(
      // backgroundColor: Colors.white,
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: ThemeController.to.getIsDarkMode
              ? containerColorDarkTheme
              : Colors.white,
          showOnTopOfTheChartBoxArea: true,
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            List<LineTooltipItem> tooltips = [];
            for (var element in touchedSpots) {
              tooltips.add(
                LineTooltipItem(
                  Functions.getCurrency(controller.homeController.getUser()) +
                      Functions.moneyFormat(element.y.toString()),
                  TextStyle(
                    fontSize: 10.sp,
                    color: ThemeController.to.getIsDarkMode
                        ? Colors.white
                        : bottomBarItemColorDarkTheme,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            return tooltips;
          },
          tooltipBorder: BorderSide(
            color: ThemeController.to.getIsDarkMode
                ? bottomBarItemColorDarkTheme
                : mainColor,
          ),
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        // horizontalInterval: 5,
        // verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: ThemeController.to.getIsDarkMode
                ? chartLinesColorDarkTheme
                : const Color(0xffF4F6FA),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: ThemeController.to.getIsDarkMode
                ? chartLinesColorDarkTheme
                : const Color(0xffF4F6FA),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          axisNameSize: 375.w,
          sideTitles: SideTitles(
            showTitles: true,
            // reservedSize: 10.h,
            interval:
                controller.getInvestmentData()?.totalInvestmentAmount.length !=
                        1
                    ? 1
                    : 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          // axisNameSize: 375.w,
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 25.w,
            // interval: 1.w,
            getTitlesWidget: (value, meta) {
              final currentValue = double.parse(
                  controller.homeController.getUser()?.currentValue ?? '0');
              if (currentValue != value) {
                if (value >= meta.max) {
                  return SizedBox.shrink();
                }
              }
              return Text(
                meta.formattedValue,
                style: TextStyle(
                  color: ThemeController.to.getIsDarkMode
                      ? unselectedBottomBarItemColorDarkTheme
                      : Color(0xff5A5A5C),
                  fontWeight: FontWeight.w400,
                  fontSize: 10.sp,
                ),
              );
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
            color: ThemeController.to.getIsDarkMode
                ? chartLinesColorDarkTheme
                : Color.fromARGB(255, 255, 255, 255)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [
            if (controller.getInvestmentData()?.firstDeposit != null) ...[
              FlSpot(
                  -1,
                  controller
                          .getInvestmentData()
                          ?.firstDeposit
                          ?.value
                          .toDouble() ??
                      0)
            ],
            ...(controller.getInvestmentData()?.totalInvestmentAmount as List)
                .mapIndexed((e, index) =>
                    FlSpot(index.toDouble(), double.parse(e.toString())))
                .toList(),
            FlSpot(
              controller
                  .getInvestmentData()
                  ?.totalInvestmentAmount
                  .length
                  .toDouble(),
              double.parse(
                  controller.homeController.getUser()?.currentValue ?? '0'),
            ),
          ],
          isCurved: true,
          color: ThemeController.to.getIsDarkMode
              ? bottomBarItemColorDarkTheme
              : Color(0xFF0A71B9),
          barWidth: 2.h,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (p0, p1, p2, p3) {
              return FlDotCirclePainter(
                color: ThemeController.to.getIsDarkMode
                    ? unselectedBottomBarItemColorDarkTheme
                    : mainColor,
                strokeColor: ThemeController.to.getIsDarkMode
                    ? chartCircleColorDarkTheme
                    : Colors.white,
                strokeWidth: 1.5.w,
              );
            },
          ),
          preventCurveOverShooting: true,
          belowBarData: BarAreaData(
            show: true,
            color: Colors.white,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: ThemeController.to.getIsDarkMode
                  ? gradientColorsDarkTheme.map((color) => color).toList()
                  : gradientColorsLightTheme.map((color) => color).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: ThemeController.to.getIsDarkMode
          ? unselectedBottomBarItemColorDarkTheme
          : Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 8.sp,
    );
    Widget text;

    if (value.toInt() == -1) {
      if (controller.getInvestmentData()?.firstDeposit == null) {
        return SizedBox.shrink();
        // return Expanded(
        //   child: SideTitleWidget(
        //     axisSide: meta.axisSide,
        //     space: 10.h,
        //     child: SizedBox.shrink(),
        //   ),
        // );
      }
      // print(controller.getInvestmentData()?.firstDeposit?.date);
      text = Text(
        // controller.getDepositsData()?.days?[value.toInt()] ?? '',
        intl.DateFormat.Md()
            .format(controller.getInvestmentData()?.firstDeposit?.date ?? ''),
        style: style,
        maxLines: 1,
        textAlign: TextAlign.left,
      );

      return Expanded(
        child: SideTitleWidget(
          axisSide: meta.axisSide,
          space: 10.h,
          child: text,
        ),
      );
    } else if (value.toInt() ==
        controller.getInvestmentData()?.totalInvestmentAmount.length) {
      text = Text(
        // controller.getDepositsData()?.days?[value.toInt()] ?? '',
        // intl.DateFormat.Md().format(DateTime.now()),
        intl.DateFormat.Md().format(tz.TZDateTime.now(kuwaitTimezoneLocation)),
        style: style,
        maxLines: 1,
        textAlign: TextAlign.left,
      );

      return Expanded(
        child: SideTitleWidget(
          axisSide: meta.axisSide,
          space: 10.h,
          child: text,
        ),
      );
    }

    if (controller.getChoice() == 0) {
      text = Text(
        // controller.getDepositsData()?.days?[value.toInt()] ?? '',
        intl.DateFormat.Md().format(tz.TZDateTime.parse(kuwaitTimezoneLocation,
            controller.getInvestmentData()?.days?[value.toInt()] ?? '')),
        style: style,
        maxLines: 1,
        textAlign: TextAlign.left,
      );
    } else if (controller.getChoice() == 1) {
      text = Text(
        controller
                .getInvestmentData()
                ?.months?[value.toInt()]
                .toString()
                .substring(0, 3) ??
            '',
        style: style,
        maxLines: 1,
        textAlign: TextAlign.left,
      );
    } else {
      text = Text(
        // controller.getDepositsData()?.days?[value.toInt()] ?? '',

        controller.getInvestmentData()?.years?[value.toInt()] ?? '',
        style: style,
        maxLines: 1,
        textAlign: TextAlign.left,
      );
    }

    return Expanded(
      child: SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10.h,
        child: text,
      ),
    );
  }
}

List<Color> gradientColorsLightTheme = [
  const Color(0xff0171AA),
  const Color(0xff0171AA).withOpacity(0),
];

List<Color> gradientColorsDarkTheme = [
  bottomBarItemColorDarkTheme,
  bottomBarItemColorDarkTheme.withOpacity(0),
];

class MyData {
  final int year;
  final int sales;

  MyData(this.year, this.sales);
}

class MyFooter extends Footer {
  MyFooter({required super.triggerOffset, required super.clamping});

  @override
  Widget build(BuildContext context, IndicatorState state) {
    return SizedBox.shrink();
  }
}
