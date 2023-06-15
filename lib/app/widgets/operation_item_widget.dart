import 'package:app/app/modules/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app/app/utils/utils.dart';

class OperationItemWidget extends StatelessWidget {
  final String fullname;
  final String? bankAccountNumber;
  final String amount;
  final String date;
  const OperationItemWidget({
    Key? key,
    required this.fullname,
    required this.bankAccountNumber,
    required this.amount,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 343.w,
        height: 70,
        margin: EdgeInsets.only(bottom: 12.h),
        padding:
            EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 11.h),
        decoration: BoxDecoration(
          color: ThemeController.to.getIsDarkMode
              ? containerColorDarkTheme
              : containerColorLightTheme,
          // borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fullname,
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
                  amount,
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
                  Functions.maskString(bankAccountNumber),
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
                  date,
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
          ],
        ),
      ),
    );
  }
}
