import 'dart:io';

import 'package:app/app/modules/edit_profile/providers/user_provider.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: EditProfilePage(),
    );
  }
}

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      init: EditProfileController(userProvider: Get.find<UserProvider>()),
      builder: (controller) => ListView(
        // mainAxisSize: MainAxisSize.min,
        shrinkWrap: true,
        controller: controller.controller,
        // physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 70.h,
            color: mainColor,
            child: PageHeaderWidget(
              title: 'profile'.tr,
              canBack: true,
              hasNotificationIcon: false,
              icon: const SizedBox(),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
            child: Form(
              key: controller.getFormKey(),
              autovalidateMode: AutovalidateMode.disabled,
              child: ListView(
                shrinkWrap: true,
                // controller: controller.controller,
                // physics: BouncingScrollPhysics(),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const ProfileChangeImageWidget(),
                  SizedBox(height: 15.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 17.w, left: 16.w),
                        child: Text(
                          'profile'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                            //fontFamily: FontFamily.inter,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        margin: EdgeInsets.only(right: 17.w, left: 16.w),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              cursorColor: mainColor,
                              readOnly: true,
                              initialValue: controller.getEmail(),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelText: 'email'.tr,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TextFormField(
                              cursorColor: mainColor,
                              focusNode: controller.focusNodes[0],
                              readOnly: true,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              initialValue: controller.getUsername(),
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                labelText: 'username'.tr,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TextFormField(
                              controller:
                                  controller.passwordTextEditController.value,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (value) {
                                if (value?.isNotEmpty ?? false) {
                                  if (value!.length < 8) {
                                    return 'min_size_field'.trParams({
                                      'name': 'password'.tr,
                                      'size': 8.toString(),
                                    });
                                  }
                                  if (RegExp(r'[\u0621-\u064A]', unicode: true)
                                      .hasMatch(value)) {
                                    return 'just_english_characters'.trParams({
                                      'name': 'password'.tr,
                                    });
                                  }
                                }
                                return null;
                              },
                              cursorColor: mainColor,
                              obscureText: controller.obscureText.value,
                              focusNode: controller.focusNodes[1],
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                hintText: '**********',
                                filled: controller.focusNodes[1].hasFocus
                                    ? true
                                    : false,
                                fillColor: mainColor.withOpacity(0.1),
                                label: Row(
                                  children: [
                                    Text('password'.tr),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit,
                                        color: controller.focusNodes[1].hasFocus
                                            ? mainColor
                                            : Colors.grey,
                                        size: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                suffixIcon: IconButton(
                                  onPressed: controller.setObscureText,
                                  icon: Icon(
                                      controller.obscureText.value
                                          ? Icons.remove_red_eye_outlined
                                          : Icons.visibility_off_outlined,
                                      color: eyeIconColor,
                                      size: 20),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(right: 17.w, left: 16.w, top: 15.h),
                        child: Text(
                          'portfolio'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                            //fontFamily: FontFamily.inter,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        margin: EdgeInsets.only(right: 17.w, left: 16.w),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              cursorColor: mainColor,
                              readOnly: true,
                              initialValue: controller.getPortfolioName(),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelText: 'portfolio'.tr,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            MediaQuery.removePadding(
                              context: context,
                              removeBottom: true,
                              removeTop: true,
                              child: RawScrollbar(
                                thumbVisibility: true,
                                thumbColor: mainColor,
                                thickness: 3.w,
                                radius: Radius.circular(8.r),
                                interactive: true,
                                child: TextFormField(
                                  cursorColor: mainColor,
                                  readOnly: true,
                                  maxLines: 8,
                                  style: TextStyle(
                                    color: softGreyColor,
                                    fontSize: 14.sp,
                                  ),
                                  textAlign: TextAlign.justify,
                                  initialValue:
                                      controller.getPortfolioDescription(),
                                  decoration: InputDecoration(
                                    errorMaxLines: 2,
                                    labelText: 'details'.tr,
                                    labelStyle: TextStyle(
                                      //fontFamily: FontFamily.inter,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: strokeColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: strokeColor,
                                        width: 1.0,
                                      ),
                                    ),
                                    hintStyle: TextStyle(
                                      //fontFamily: FontFamily.inter,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide(
                                        color: strokeColor,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TextFormField(
                              cursorColor: mainColor,
                              readOnly: true,
                              initialValue:
                                  controller.getPortfolioInterestType(),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelText: 'plan'.tr,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TextFormField(
                              cursorColor: mainColor,
                              initialValue:
                                  controller.getPortfolioWithdrawDays(),
                              readOnly: true,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelText: 'income'.tr,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TextFormField(
                              cursorColor: mainColor,
                              readOnly: true,
                              initialValue:
                                  controller.getPortfolioInterestPercent(),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelText: 'expected_return'.tr,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TextFormField(
                              cursorColor: mainColor,
                              initialValue: controller.getCurrency(),
                              readOnly: true,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelText: 'currency'.tr,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(right: 17.w, left: 16.w, top: 15.h),
                        child: Text(
                          'personal_information'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                            //fontFamily: FontFamily.inter,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        margin: EdgeInsets.only(right: 17.w, left: 16.w),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller:
                                  controller.firstNameTextEditController.value,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (value) {
                                if (value != null) {
                                  if (value.isNotEmpty) {
                                    if (value.contains(new RegExp(r'[0-9]'))) {
                                      return 'no_numbers_in_field'.tr;
                                    }
                                  }
                                }
                                if (value?.isEmpty ?? true) {
                                  return 'required_field'.trParams({
                                    'name': 'first_name'.tr,
                                  });
                                }
                                return null;
                              },
                              cursorColor: mainColor,
                              focusNode: controller.focusNodes[2],
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                filled: controller.focusNodes[2].hasFocus
                                    ? true
                                    : false,
                                fillColor: mainColor.withOpacity(0.1),
                                label: Row(
                                  children: [
                                    Text('first_name'.tr),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit,
                                        color: controller.focusNodes[2].hasFocus
                                            ? mainColor
                                            : Colors.grey,
                                        size: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TextFormField(
                              cursorColor: mainColor,
                              controller:
                                  controller.lastNameTextEditController.value,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (value) {
                                if (value != null) {
                                  if (value.isNotEmpty) {
                                    if (value.contains(new RegExp(r'[0-9]'))) {
                                      return 'no_numbers_in_field'.tr;
                                    }
                                  }
                                }
                                if (value?.isEmpty ?? true) {
                                  return 'required_field'.trParams({
                                    'name': 'last_name'.tr,
                                  });
                                }
                                return null;
                              },
                              focusNode: controller.focusNodes[3],
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                filled: controller.focusNodes[3].hasFocus
                                    ? true
                                    : false,
                                fillColor: mainColor.withOpacity(0.1),
                                label: Row(
                                  children: [
                                    Text('last_name'.tr),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit,
                                        color: controller.focusNodes[3].hasFocus
                                            ? mainColor
                                            : Colors.grey,
                                        size: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            Container(
                              // height: 52.h,
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: strokeColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButtonFormField<String>(
                                  value: controller.getGenderSelect(),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'required_field'.trParams({
                                        'name': 'gender'.tr,
                                      });
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    constraints:
                                        BoxConstraints(minHeight: 52.h),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    // errorBorder: UnderlineInputBorder(
                                    //     borderSide: BorderSide(width: 0)),
                                    // focusedErrorBorder: UnderlineInputBorder(
                                    //     borderSide: BorderSide(width: 0)),
                                  ),
                                  icon:
                                      Icon(Icons.keyboard_arrow_down_outlined),
                                  hint: Text(
                                    'gender'.tr,
                                    style: TextStyle(
                                      fontFamily: Get.locale?.languageCode
                                                  .compareTo('ar') ==
                                              0
                                          ? FontFamily.tajawal
                                          : FontFamily.inter,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: textFieldColor,
                                    ),
                                  ),
                                  style: TextStyle(
                                    //fontFamily: FontFamily.inter,
                                    fontFamily: Get.locale?.languageCode
                                                .compareTo('ar') ==
                                            0
                                        ? FontFamily.tajawal
                                        : FontFamily.inter,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: textColor,
                                  ),
                                  isDense: true,
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem(
                                        child: Text("male".tr), value: "male"),
                                    DropdownMenuItem(
                                        child: Text("female".tr),
                                        value: "female"),
                                  ],
                                  onChanged: controller.setGenderSelect,
                                ),
                              ),
                            ),
                            SizedBox(height: 28.h),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: controller
                                        .countryTextEditController.value,
                                    cursorColor: mainColor,
                                    readOnly: true,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    focusNode:
                                        FocusScopeNode(canRequestFocus: false),
                                    onTap: () async {
                                      controller.showCountryModal();
                                    },
                                    decoration: InputDecoration(
                                      errorMaxLines: 2,
                                      hintText: 'country'.tr,
                                      labelStyle: TextStyle(
                                        //fontFamily: FontFamily.inter,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      label: Row(
                                        children: [
                                          Text('country'.tr),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.edit,
                                              color: controller
                                                      .focusNodes[0].hasFocus
                                                  ? mainColor
                                                  : Colors.grey,
                                              size: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: strokeColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: strokeColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        //fontFamily: FontFamily.inter,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: strokeColor,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: mainColor,
                                    controller:
                                        controller.cityTextEditController.value,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    validator: (value) {
                                      if (value?.isEmpty ?? true) {
                                        return 'required_field'.trParams({
                                          'name': 'city'.tr,
                                        });
                                      }
                                      return null;
                                    },
                                    focusNode: controller.focusNodes[4],
                                    decoration: InputDecoration(
                                      errorMaxLines: 2,
                                      labelStyle: TextStyle(
                                        //fontFamily: FontFamily.inter,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      filled: controller.focusNodes[4].hasFocus
                                          ? true
                                          : false,
                                      fillColor: mainColor.withOpacity(0.1),
                                      hintText: 'city'.tr,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                      label: Row(
                                        children: [
                                          Text('city'.tr),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.edit,
                                              color: controller
                                                      .focusNodes[4].hasFocus
                                                  ? mainColor
                                                  : Colors.grey,
                                              size: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: strokeColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: strokeColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        //fontFamily: FontFamily.inter,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: strokeColor,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 14.h),
                            TextFormField(
                              controller:
                                  controller.phoneNumberController.value,
                              autovalidateMode: AutovalidateMode.disabled,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'required_field'.trParams({
                                    'name': 'phone_number'.tr,
                                  });
                                }
                                if (Functions.isMobileNumberValid(
                                    controller.countryDialCode.value +
                                        (value ?? ''))) {
                                  return 'invalid_phone_number'.tr;
                                }
                                return null;
                              },
                              cursorColor: mainColor,
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                hintText: 'phone_number'.tr,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            // Obx(
                            //   () => PhoneNumberInput(
                            //     controller:
                            //         controller.phoneNumberController.value,
                            //     // initialCountry: 'SA',
                            //     locale: Get.locale?.languageCode ?? 'en',
                            //     allowPickFromContacts: false,
                            //     countryListMode: CountryListMode.dialog,
                            //     contactsPickerPosition:
                            //         ContactsPickerPosition.suffix,
                            //     enabledBorder: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(8),
                            //         borderSide: BorderSide(color: strokeColor)),
                            //     focusedBorder: OutlineInputBorder(
                            //       borderRadius: BorderRadius.circular(8),
                            //       borderSide: BorderSide(color: strokeColor),
                            //     ),
                            //     hint: 'XXXXXXXXXXX',
                            //   ),
                            // ),
                            SizedBox(height: 14.h),
                          ],
                        ),
                      ),
                      // SizedBox(height: 40.h),

                      SizedBox(height: 14.h),
                    ],
                  ),
                  Column(
                    key: GlobalObjectKey('uni'),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(right: 17.w, left: 16.w, top: 15.h),
                        child: Text(
                          'banking_details'.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                            //fontFamily: FontFamily.inter,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        margin: EdgeInsets.only(right: 17.w, left: 16.w),
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              cursorColor: mainColor,
                              controller:
                                  controller.bankNameTextEditController.value,
                              focusNode: controller.focusNodes[5],
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (value) {
                                if ((value == null || value.isEmpty) &&
                                    controller.getIsBankingRequired()) {
                                  return 'required_field'.trParams({
                                    'name': 'bank_name'.tr,
                                  });
                                }
                                if (value != null) {
                                  if (value.isNotEmpty) {
                                    if (RegExp(r'[\u0621-\u064A]',
                                            unicode: true)
                                        .hasMatch(value)) {
                                      return 'just_english_characters'
                                          .trParams({
                                        'name': 'bank_name'.tr,
                                      });
                                    }
                                  }
                                  if (value.contains(new RegExp(r'[0-9]'))) {
                                    return 'no_numbers_in_field'.tr;
                                  }
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                filled: controller.focusNodes[5].hasFocus
                                    ? true
                                    : false,
                                fillColor: mainColor.withOpacity(0.1),
                                label: Row(
                                  children: [
                                    Text('bank_name'.tr),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit,
                                        color: controller.focusNodes[5].hasFocus
                                            ? mainColor
                                            : Colors.grey,
                                        size: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TextFormField(
                              cursorColor: mainColor,
                              controller: controller
                                  .bankAccountNumberTextEditController.value,
                              focusNode: controller.focusNodes[6],
                              validator: (value) {
                                // if (value != null && value.length > 0) {
                                //   return null;
                                // }
                                if ((value == null || value.isEmpty) &&
                                    controller.getIsBankingRequired()) {
                                  return 'required_field'.trParams({
                                    'name': 'bank_account_number'.tr,
                                  });
                                }
                                if (value != null) {
                                  if (value.isNotEmpty) {
                                    if (!RegExp(r"^[0-9]+$").hasMatch(value)) {
                                      return 'just_numbers'.tr;
                                    }
                                  }
                                  return null;
                                }

                                return null;
                              },
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                filled: controller.focusNodes[6].hasFocus
                                    ? true
                                    : false,
                                fillColor: mainColor.withOpacity(0.1),
                                label: Row(
                                  children: [
                                    Text('bank_account_number'.tr),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit,
                                        color: controller.focusNodes[6].hasFocus
                                            ? mainColor
                                            : Colors.grey,
                                        size: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TextFormField(
                              cursorColor: mainColor,
                              controller: controller
                                  .bankAccountNameTextEditController.value,
                              autovalidateMode: AutovalidateMode.disabled,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (value) {
                                if ((value == null || value.isEmpty) &&
                                    controller.getIsBankingRequired()) {
                                  return 'required_field'.trParams({
                                    'name': 'bank_account_name'.tr,
                                  });
                                }
                                if (value != null) {
                                  if (value.isNotEmpty) {
                                    if (RegExp(r'[\u0621-\u064A]',
                                            unicode: true)
                                        .hasMatch(value)) {
                                      return 'just_english_characters'
                                          .trParams({
                                        'name': 'bank_account_name'.tr,
                                      });
                                    }
                                  }
                                  if (value.contains(new RegExp(r'[0-9]'))) {
                                    return 'no_numbers_in_field'.tr;
                                  }
                                }
                                return null;
                              },
                              focusNode: controller.focusNodes[7],
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                filled: controller.focusNodes[7].hasFocus
                                    ? true
                                    : false,
                                fillColor: mainColor.withOpacity(0.1),
                                label: Row(
                                  children: [
                                    Text('bank_account_name'.tr),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit,
                                        color: controller.focusNodes[7].hasFocus
                                            ? mainColor
                                            : Colors.grey,
                                        size: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TextFormField(
                              cursorColor: mainColor,
                              controller: controller
                                  .bankIbanNumberTextEditController.value,
                              focusNode: controller.focusNodes[8],
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              validator: (value) {
                                if ((value == null || value.isEmpty) &&
                                    controller.getIsBankingRequired()) {
                                  return 'required_field'.trParams({
                                    'name': 'iban'.tr,
                                  });
                                }
                                if (value != null) {
                                  if (value.isNotEmpty) {
                                    if (RegExp(r'[\u0621-\u064A]',
                                            unicode: true)
                                        .hasMatch(value)) {
                                      return 'just_english_characters'
                                          .trParams({
                                        'name': 'bank_account_name'.tr,
                                      });
                                    }
                                  }
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                filled: controller.focusNodes[8].hasFocus
                                    ? true
                                    : false,
                                fillColor: mainColor.withOpacity(0.1),
                                label: Row(
                                  children: [
                                    Text('iban'.tr),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit,
                                        color: controller.focusNodes[8].hasFocus
                                            ? mainColor
                                            : Colors.grey,
                                        size: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                                hintStyle: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: strokeColor,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 14.h),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Obx(
                        () => controller.getIsLoading()
                            ? Center(
                                child: SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 17.w),
                                child: TextButton(
                                  onPressed: controller.onUpdateButtonClick,
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    // primary: mainColor,
                                    backgroundColor: mainColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'save'.tr,
                                        style: TextStyle(
                                          //fontFamily: FontFamily.inter,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(height: 7.h),
                      Obx(
                        () => controller.getIsDeleteLoading()
                            ? Center(
                                child: SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 17.w),
                                child: TextButton(
                                  onPressed:
                                      controller.showDeleteAccountReasonDialog,
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    // primary: mainColor,
                                    backgroundColor: secondaryColor,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'delete_account'.tr,
                                        style: TextStyle(
                                          //fontFamily: FontFamily.inter,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileChangeImageWidget extends GetView<EditProfileController> {
  const ProfileChangeImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Align(
          alignment: Alignment.center,
          child: Obx(
            () => controller.getIsPhotoLoading()
                ? Center(
                    child: SizedBox(
                      width: 15.w,
                      height: 15.h,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Stack(
                    children: [
                      !controller.getFilePath().isEmpty
                          ? CircleAvatar(
                              backgroundImage: FileImage(controller.getFile()),
                              radius: 50.r,
                            )
                          : CircleAvatar(
                              radius: 50.r,
                              backgroundImage: NetworkImage(
                                Functions.getUserAvatar(
                                  controller.homeController.getUser()!.avatar ??
                                      '',
                                ),
                              ),
                            ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: controller.showImageSelection,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: mainColor,
                              border: Border.all(
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                      controller.getFilePath().isEmpty
                          ? SizedBox.shrink()
                          : Positioned(
                              left: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: () {
                                  controller.setImageFilePath(File(''));
                                  controller.setFilePath('');
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                      color: mainColor,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.red,
                                    size: 13,
                                  ),
                                ),
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: controller.onResetAvatarButtonClick,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: secondaryColor,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: Icon(
                              Icons.refresh_rounded,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
