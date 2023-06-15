import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class OptionItemWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  final VoidCallback onTap;
  final bool isLastItem;
  final bool haveIcon;
  final Iconify? icon;
  const OptionItemWidget({
    Key? key,
    required this.title,
    this.textColor = const Color(0xFF515151),
    required this.onTap,
    this.isLastItem = false,
    this.haveIcon = false,
    this.icon = null,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: isLastItem ? 2.h : 8.h),
        padding: EdgeInsets.fromLTRB(17.w, 18.h, 16.w, 18.h),
        decoration: BoxDecoration(
          color: ThemeController.to.getIsDarkMode
              ? containerColorDarkTheme
              : containerColorLightTheme,
          border: Border.all(
            color: ThemeController.to.getIsDarkMode
                ? greyColor.withOpacity(.39)
                : strokeColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (haveIcon) ...[
                  icon!,
                  SizedBox(width: 15.w),
                ],
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ThemeController.to.getIsDarkMode
                        ? unselectedBottomBarItemColorDarkTheme
                        : textColor,
                    //fontFamily: FontFamily.inter,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: ThemeController.to.getIsDarkMode
                  ? unselectedBottomBarItemColorDarkTheme
                  : softGreyColor,
            ),
          ],
        ),
      ),
    );
  }
}
