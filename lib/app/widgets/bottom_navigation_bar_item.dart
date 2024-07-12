import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class StretchedBottomNavigationBarItem extends GetView<HomeController> {
  final bool? isHome;
  final String title;
  final String? icon;
  final bool isSelected;
  final int index;
  final bool isNotification;
  final bool iswarning;
  const StretchedBottomNavigationBarItem(
      {super.key,
      required this.title,
      this.icon,
      this.isHome = true,
      this.isSelected = false,
      this.isNotification = false,
      required this.index,
      this.iswarning = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => controller.setIndex(index),
        child: Stack(
          children: [
            index == 4 && iswarning
                ? Positioned(
                    right: 15,
                    top: 5,
                    child: Icon(
                      CupertinoIcons.info,
                      size: 18,
                      color: Colors.amber,
                    ),
                  )
                : SizedBox(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isHome!) ...[
                    if (index == 9) ...[
                      Assets.images.svg.arcticonsCalculator.svg(
                        color: controller.isSelected(index)
                            ? (ThemeController.to.getIsDarkMode
                                ? bottomBarItemColorDarkTheme
                                : mainColor)
                            : (ThemeController.to.getIsDarkMode
                                ? unselectedBottomBarItemColorDarkTheme
                                : unselectedBottomBarItemColorLightTheme),
                        width: 24.w,
                        height: 24.h,
                      ),
                    ]
                    //  else if (index == 4) ...[
                    //   Assets.images.svg.heroiconsUser.svg(
                    //     color: controller.isSelected(index) ? mainColor : unselectedBottomBarItemColor,
                    //     width: 24.w,
                    //     height: 24.h,
                    //   ),
                    // ]
                    else ...[
                      Iconify(
                        icon!,
                        color: index == 4 && iswarning
                            ? Colors.amber
                            : controller.isSelected(index)
                                ? (ThemeController.to.getIsDarkMode
                                    ? bottomBarItemColorDarkTheme
                                    : mainColor)
                                : (ThemeController.to.getIsDarkMode
                                    ? unselectedBottomBarItemColorDarkTheme
                                    : unselectedBottomBarItemColorLightTheme),
                        size: 20,
                      ),
                    ]
                  ] else ...[
                    Assets.images.svg.home.svg(
                      color: controller.isSelected(index)
                          ? (ThemeController.to.getIsDarkMode
                              ? bottomBarItemColorDarkTheme
                              : mainColor)
                          : (ThemeController.to.getIsDarkMode
                              ? unselectedBottomBarItemColorDarkTheme
                              : unselectedBottomBarItemColorLightTheme),
                      width: 15.w,
                      height: 15.h,
                    ),
                  ],
                  SizedBox(height: 7.h),
                  Text(
                    title,
                    style: TextStyle(
                      //fontFamily: FontFamily.inter,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: index == 4 && iswarning
                          ? Colors.amber
                          : controller.isSelected(index)
                              ? (ThemeController.to.getIsDarkMode
                                  ? bottomBarItemColorDarkTheme
                                  : mainColor)
                              : (ThemeController.to.getIsDarkMode
                                  ? unselectedBottomBarItemColorDarkTheme
                                  : unselectedBottomBarItemColorLightTheme),
                    ),
                  ),
                  SizedBox(height: 7.h),
                ],
              ),
            ),
            isNotification
                ? Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: 49.h,
                        left: 27.w,
                        child: Container(
                          height: 8.h,
                          width: 8.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.orange.withOpacity(.5),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
