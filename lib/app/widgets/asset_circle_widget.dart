import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AssetCircleWidget extends StatelessWidget {
  final Color color;
  final String name;
  const AssetCircleWidget({
    Key? key,
    required this.color,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 7.w,
          height: 7.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 4.w),
        Padding(
          padding: EdgeInsets.only(
              top: (Get.locale?.languageCode.compareTo('ar') == 0)
                  ? 5.h
                  : 3.5.h),
          child: Text(
            name,
            style: TextStyle(
              fontSize: (Get.locale?.languageCode.compareTo('ar') == 0)
                  ? 13.sp
                  : 12.sp,
              fontWeight: FontWeight.w500,
              color: ThemeController.to.getIsDarkMode
                  ? unselectedBottomBarItemColorDarkTheme
                  : unselectedBottomBarItemColorLightTheme,
              //fontFamily: FontFamily.inter,
            ),
          ),
        ),
      ],
    );
  }
}
