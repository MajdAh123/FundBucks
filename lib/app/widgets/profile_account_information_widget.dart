import 'package:app/app/modules/home/controllers/profile_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileAccountInformationWidget extends GetView<ProfileController> {
  const ProfileAccountInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.w),
      child: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100.w,
                height: 100.h,
                margin: EdgeInsets.only(right: 10.w),
                child: CircleAvatar(
                  backgroundColor: ThemeController.to.getIsDarkMode
                      ? bottomBarItemColorDarkTheme
                      : mainColor,
                  radius: 25.r,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 47.5.r,
                    child: controller.homeController.getUser()!.avatar == null
                        ? SizedBox()
                        : CircleAvatar(
                            radius: 45.5.r,
                            backgroundImage: NetworkImage(
                              Functions.getUserAvatar(
                                controller.homeController.getUser()!.avatar ??
                                    '',
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.getFullName(),
                    style: TextStyle(
                      //fontFamily: FontFamily.inter,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ThemeController.to.getIsDarkMode
                          ? bottomBarItemColorDarkTheme
                          : mainColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(controller.homeController.getUser()?.username ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ThemeController.to.getIsDarkMode
                            ? unselectedBottomBarItemColorDarkTheme
                            : unselectedBottomBarItemColorLightTheme,
                        //fontFamily: FontFamily.inter,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
