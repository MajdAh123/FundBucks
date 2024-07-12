import 'package:app/app/modules/home/controllers/profile_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:dark_light_button/dark_light_button.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  // SizedBox(height: 8.h),

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
                  SizedBox(height: 6.h),
                  // Text(
                  //     "#${controller.homeController.getUser()?.account_number.toString()}" ??
                  //         '',
                  //     style: TextStyle(
                  //       fontSize: 15.sp,
                  //       letterSpacing: 2,
                  //       color: ThemeController.to.getIsDarkMode
                  //           ? unselectedBottomBarItemColorDarkTheme
                  //           : unselectedBottomBarItemColorLightTheme,
                  //       //fontFamily: FontFamily.inter,
                  //       fontWeight: FontWeight.w800,
                  //     )),
                  // SizedBox(height: 2.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Text(
                        controller.homeController.getUser()?.username ?? '',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: ThemeController.to.getIsDarkMode
                                ? unselectedBottomBarItemColorDarkTheme
                                : unselectedBottomBarItemColorLightTheme,
                            //fontFamily: FontFamily.inter,
                            fontWeight: FontWeight.w500,
                            height: 0.9)),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     border: Border.all(
              //         color: ThemeController.to.getIsDarkMode
              //             ? unselectedBottomBarItemColorDarkTheme
              //             : unselectedBottomBarItemColorLightTheme,
              //         width: 2
              //         // top: BorderSide(
              //         //     color: ThemeController.to.getIsDarkMode
              //         //         ? mainColorDarkTheme
              //         //         : mainColor,
              //         //     width: 2),
              //         // bottom: BorderSide(

              //         // color:
              //         // ThemeController.to.getIsDarkMode
              //         //     ? bottomBarItemColorDarkTheme
              //         //     : mainColor,
              //         // width: 2)
              //         ),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Container(
              //         margin: EdgeInsets.only(top: 3.h),
              //         child: Text(
              //           "${controller.homeController.getUser()?.account_number.toString()}",
              //           style: TextStyle(
              //             fontSize: 12.sp,
              //             letterSpacing: 2,
              //             // fontWeight: FontWeight.bold,
              //             color: ThemeController.to.getIsDarkMode
              //                 ? unselectedBottomBarItemColorDarkTheme
              //                 : unselectedBottomBarItemColorLightTheme,
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 4.h),
              DarlightButton(
                type: Darlights.DarlightTwo,
                onChange: (ThemeMode theme) {
                  controller.changeTheme(theme == ThemeMode.dark);
                },
                options: DarlightTwoOption(
                  lightBackGroundColor: Colors.transparent,
                  darkBackGroundColor: Colors.transparent,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
