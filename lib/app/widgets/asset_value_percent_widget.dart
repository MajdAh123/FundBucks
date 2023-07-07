import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AssetValuePercentWidget extends StatelessWidget {
  final AssetModel model;
  final String currency;

  const AssetValuePercentWidget({
    Key? key,
    required this.model,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 7.w,
          height: 7.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: model.color,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          '${(model.percent * 100).toStringAsFixed(2)}%',
          style: TextStyle(
            fontSize:
                (Get.locale?.languageCode.compareTo('ar') == 0) ? 11.sp : 10.sp,
            fontWeight: FontWeight.w500,
            color: ThemeController.to.getIsDarkMode
                ? unselectedBottomBarItemColorDarkTheme
                : unselectedBottomBarItemColorLightTheme,
            //fontFamily: FontFamily.inter,
          ),
        ),
        Text(
          '${currency}${Functions.moneyFormat(model.value.toStringAsFixed(2))}',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize:
                (Get.locale?.languageCode.compareTo('ar') == 0) ? 11.sp : 10.sp,
            fontWeight: FontWeight.w500,
            color: ThemeController.to.getIsDarkMode
                ? unselectedBottomBarItemColorDarkTheme
                : unselectedBottomBarItemColorLightTheme,
            //fontFamily: FontFamily.inter,
          ),
        ),
      ],
    );
  }
}
