import 'package:app/app/modules/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app/app/utils/utils.dart';

class ReportItemWidget extends StatelessWidget {
  final String notes;
  final double amount;
  final double totalAmount;
  final double returnPercent;
  final double returnValue;
  final String from;
  final String to;
  final String currency;
  final Widget icon;
  const ReportItemWidget({
    Key? key,
    required this.notes,
    required this.amount,
    required this.totalAmount,
    required this.returnPercent,
    required this.returnValue,
    required this.from,
    required this.to,
    required this.icon,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 95.h,
      margin: EdgeInsets.only(bottom: 20.h),
      padding:
          EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 11.h),
      decoration: BoxDecoration(
        color: ThemeController.to.getIsDarkMode
            ? containerColorDarkTheme
            : containerColorLightTheme,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Stack(
        // mainAxisAlignment: MainAxisAlignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -20.h,
            left: 0,
            right: 0,
            child: Center(
              child: InvestmentReportNote(
                color: ThemeController.to.getIsDarkMode
                    ? mainColorDarkTheme
                    : mainColor,
                text: notes,
                textColor: Colors.white,
                hPadding: 20,
                isTextBold: true,
                // borderRadius: ,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Functions.getAmountReport(amount, currency),
                    style: TextStyle(
                      fontSize: 13.sp,
                      //fontFamily: FontFamily.inter,
                      fontWeight: FontWeight.w600,
                      color: ThemeController.to.getIsDarkMode
                          ? containerColorLightTheme
                          : Colors.black,
                    ),
                  ),
                  Text(
                    Functions.getAmountReport(totalAmount, currency),
                    style: TextStyle(
                      fontSize: 13.sp,
                      //fontFamily: FontFamily.inter,
                      fontWeight: FontWeight.w600,
                      color: ThemeController.to.getIsDarkMode
                          ? containerColorLightTheme
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    from,
                    style: TextStyle(
                      fontSize: 12.sp,
                      //fontFamily: FontFamily.inter,
                      fontWeight: FontWeight.w500,
                      color: ThemeController.to.getIsDarkMode
                          ? unselectedBottomBarItemColorDarkTheme
                          : textFieldColor,
                    ),
                  ),
                  Text(
                    to,
                    style: TextStyle(
                      fontSize: 12.sp,
                      //fontFamily: FontFamily.inter,
                      fontWeight: FontWeight.w500,
                      color: ThemeController.to.getIsDarkMode
                          ? unselectedBottomBarItemColorDarkTheme
                          : textFieldColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
            ],
          ),
          Positioned(
            bottom: -6.45.h,
            left: 0,
            right: 0,
            child: Center(
              child: InvestmentReportNote(
                color: returnPercent == 0
                    ? greyReportBackground
                    : (returnPercent < 0
                        ? inActiveReportBackground
                        : activeBackgroundColor),
                text:
                    '( %${getValue(returnPercent)} ) ${Functions.getAmountReport(getValue(returnValue, false), currency)}',
                textColor: returnPercent == 0
                    ? greyReportText
                    : (returnPercent < 0
                        ? inActiveReportText
                        : activeTextColor),
                hPadding: 20,
                icon: icon,
                // borderRadius: ,
              ),
            ),
          ),
        ],
      ),
    );
  }

  dynamic getValue(double value, [bool returnAsString = true]) {
    if (value < 0) {
      return returnAsString ? (value * -1).toStringAsFixed(2) : value * -1;
    } else if (value == 0) {
      return returnAsString ? '00.00' : 00.00;
    }
    return returnAsString ? value.toStringAsFixed(2) : value;
  }
}

class InvestmentReportNote extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String text;
  final double borderRadius;
  final double hPadding;
  final double vPadding;
  final bool isTextBold;
  final Widget icon;
  const InvestmentReportNote({
    Key? key,
    required this.color,
    required this.textColor,
    required this.text,
    this.borderRadius = 17,
    this.hPadding = 10,
    this.vPadding = 4,
    this.isTextBold = false,
    this.icon = const SizedBox(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: hPadding.w, vertical: vPadding.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius.r),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 3.h),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: isTextBold ? FontWeight.w600 : FontWeight.w500,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (icon != SizedBox()) ...[
              SizedBox(width: 4.w),
              icon,
            ]
          ],
        ),
      ),
    );
  }
}
