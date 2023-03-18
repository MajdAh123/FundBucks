import 'dart:io';

import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      backgroundColor: backgroundColor,
      body: Obx(
        () => Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Column(
            children: [
              Container(
                height: 70.h,
                color: mainColor,
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
                          SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(),
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
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Container(
                                    width: 30.w,
                                    height: 30.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: Colors.white10)),
                                    child: Center(
                                      child: Iconify(
                                        Mdi.notification_settings_outline,
                                        color: mainColor,
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
                                      color: const Color(0xFF515151),
                                    ),
                                  ),
                                  const Spacer(),
                                  Switch(
                                    value:
                                        controller.activateNotifications.value,
                                    onChanged: (value) {
                                      controller.changeNotificationsStatus();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            // Divider(
                            //   height: 0.5.h,
                            //   color: unselectedBottomBarItemColor,
                            // ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 15.h),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Container(
                                    width: 30.w,
                                    height: 30.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: Colors.white10)),
                                    child: Center(
                                      child: Iconify(
                                        Ic.twotone_g_translate,
                                        color: mainColor,
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
                                      color: const Color(0xFF515151),
                                    ),
                                  ),
                                  const Spacer(),
                                  DropdownButton<String>(
                                    icon: Icon(Icons.chevron_right,
                                        color: softGreyColor),
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
                                            color: unselectedBottomBarItemColor,
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
                          ],
                        ),
                      ),
                    ),
              // Container(
              //   margin: EdgeInsets.only(bottom: 15.h),
              //   child: Text(
              //     'v 1.0',
              //     style: TextStyle(
              //       //fontFamily: FontFamily.inter,
              //       fontSize: 15.sp,
              //       color: mainColor,
              //       letterSpacing: 1.5,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
