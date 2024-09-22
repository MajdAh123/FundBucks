import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/logoAnimation.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.to.getIsDarkMode
          ? backgroundColorDarkTheme
          : backgroundColorLightTheme,
      body: Obx(
        () => Column(
          children: [
            Container(
              height: 90.h,
              color: ThemeController.to.getIsDarkMode
                  ? mainColorDarkTheme
                  : mainColor,
              child: PageHeaderWidget(
                title: 'settings'.tr,
                canBack: true,
                hasNotificationIcon: false,
                icon: const SizedBox(),
              ),
            ),
            controller.getIsLoading()
                ? Center(
                    child: Column(
                      children: [
                        SizedBox(height: 30.h),
                        LoadingLogoWidget(
                          width: 60,
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 17.w, right: 16.w, top: 20.h, bottom: 15.h),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 15.h),
                            color: ThemeController.to.getIsDarkMode
                                ? containerColorDarkTheme
                                : containerColorLightTheme,
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 30.w,
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.white10,
                                    ),
                                  ),
                                  child: Center(
                                    child: Iconify(
                                      Mdi.notification_settings_outline,
                                      color: ThemeController.to.getIsDarkMode
                                          ? Colors.white
                                          : mainColor,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                Text(
                                  'notifications'.tr,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    //fontFamily: FontFamily.inter,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeController.to.getIsDarkMode
                                        ? unselectedBottomBarItemColorDarkTheme
                                        : const Color(0xFF515151),
                                  ),
                                ),
                                const Spacer(),
                                Switch(
                                  value: controller.activateNotifications.value,
                                  activeColor: ThemeController.to.getIsDarkMode
                                      ? bottomBarItemColorDarkTheme
                                      : mainColor,
                                  inactiveTrackColor:
                                      ThemeController.to.getIsDarkMode
                                          ? greyColor
                                          : greyReportBackground,
                                  // inactiveThumbColor: Colors.red,
                                  onChanged: (value) {
                                    controller.changeNotificationsStatus();
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 15.h,
                            ),
                            color: ThemeController.to.getIsDarkMode
                                ? containerColorDarkTheme
                                : containerColorLightTheme,
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 30.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.white10,
                                    ),
                                  ),
                                  child: Center(
                                    child: Iconify(
                                      Mdi.theme_light_dark,
                                      color: ThemeController.to.getIsDarkMode
                                          ? Colors.white
                                          : mainColor,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                Text(
                                  'dark_mode'.tr,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    //fontFamily: FontFamily.inter,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeController.to.getIsDarkMode
                                        ? unselectedBottomBarItemColorDarkTheme
                                        : const Color(0xFF515151),
                                  ),
                                ),
                                const Spacer(),
                                Switch(
                                  inactiveTrackColor:
                                      ThemeController.to.getIsDarkMode
                                          ? greyColor
                                          : greyReportBackground,
                                  value: ThemeController.to.getIsDarkMode,
                                  activeColor: ThemeController.to.getIsDarkMode
                                      ? bottomBarItemColorDarkTheme
                                      : mainColor,
                                  onChanged: (value) {
                                    controller.changeTheme(value);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 15.h,
                            ),
                            color: ThemeController.to.getIsDarkMode
                                ? containerColorDarkTheme
                                : containerColorLightTheme,
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 30.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.white10,
                                    ),
                                  ),
                                  child: Center(
                                    child: Iconify(
                                      Mdi.lock_add,
                                      color: ThemeController.to.getIsDarkMode
                                          ? Colors.white
                                          : mainColor,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                Text(
                                  'active_auth'.tr,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    //fontFamily: FontFamily.inter,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeController.to.getIsDarkMode
                                        ? unselectedBottomBarItemColorDarkTheme
                                        : const Color(0xFF515151),
                                  ),
                                ),
                                const Spacer(),
                                Switch(
                                  inactiveTrackColor:
                                      ThemeController.to.getIsDarkMode
                                          ? greyColor
                                          : greyReportBackground,
                                  value: controller.activeLocalAuth.value,
                                  activeColor: ThemeController.to.getIsDarkMode
                                      ? bottomBarItemColorDarkTheme
                                      : mainColor,
                                  onChanged: (value) {
                                    controller.changeLocalAuthStauts();
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),

                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 15.h),
                            color: ThemeController.to.getIsDarkMode
                                ? containerColorDarkTheme
                                : containerColorLightTheme,
                            child: Row(
                              children: [
                                Container(
                                  width: 30.w,
                                  height: 30.w,
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.white10,
                                    ),
                                  ),
                                  child: Center(
                                    child: Iconify(
                                      Ic.twotone_g_translate,
                                      color: ThemeController.to.getIsDarkMode
                                          ? Colors.white
                                          : mainColor,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15.w),
                                Text(
                                  'language'.tr,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    //fontFamily: FontFamily.inter,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeController.to.getIsDarkMode
                                        ? unselectedBottomBarItemColorDarkTheme
                                        : const Color(0xFF515151),
                                  ),
                                ),
                                const Spacer(),
                                DropdownButton<String>(
                                  dropdownColor: Theme.of(context).canvasColor,
                                  icon: Icon(
                                    Icons.chevron_right,
                                    color: softGreyColor,
                                  ),
                                  underline: SizedBox(),
                                  value: Get.locale?.languageCode
                                              .compareTo('ar') ==
                                          0
                                      ? 'العربية'
                                      : 'English',
                                  items: <String>['English', 'العربية']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          //fontFamily: FontFamily.inter,
                                          fontWeight: FontWeight.w600,
                                          color: ThemeController
                                                  .to.getIsDarkMode
                                              ? unselectedBottomBarItemColorDarkTheme
                                              : unselectedBottomBarItemColorLightTheme,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    controller.changeLanguage(newValue ?? '');
                                    // Navigator.of(context).pushReplacement(
                                    //     MaterialPageRoute(
                                    //         builder: (_) => const LoginScreen()));
                                  },
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
