import 'dart:io';
import 'package:app/app/modules/edit_profile/views/countriesPage.dart';
import 'package:app/app/modules/edit_profile/views/showImage.dart';
import 'package:app/app/modules/edit_profile/providers/user_provider.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/logoAnimation.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.to.getIsDarkMode
          ? backgroundColorDarkTheme
          : backgroundColorLightTheme,
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
      builder: (controller) => WillPopScope(
        onWillPop: () async => await controller.showExitConfirmationDialog(),
        child: ListView(
          // mainAxisSize: MainAxisSize.min,
          shrinkWrap: true,
          controller: controller.homeController.controllerEditeProfile,
          // physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: 70.h,
              color: ThemeController.to.getIsDarkMode
                  ? mainColorDarkTheme
                  : mainColor,
              child: Center(
                child: PageHeaderWidget(
                  title: 'profile'.tr,
                  canBack: true,
                  hasNotificationIcon: false,
                  icon: const SizedBox(),
                  paddingTop: 0,
                  onTapBack: () async => await controller
                      .showExitConfirmationDialog()
                      .then((value) => value ? Get.back() : null),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(controller.fcm_token.value),
            // ),
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
                              color: ThemeController.to.getIsDarkMode
                                  ? bottomBarItemColorDarkTheme
                                  : mainColor,
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
                            color: ThemeController.to.getIsDarkMode
                                ? containerColorDarkTheme
                                : containerColorLightTheme,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                cursorColor: ThemeController.to.getIsDarkMode
                                    ? bottomBarItemColorDarkTheme
                                    : mainColor,
                                readOnly: true,
                                initialValue: controller.getEmail(),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
                                ),
                                decoration: InputDecoration(
                                  errorMaxLines: 2,
                                  labelText: 'email'.tr,
                                  labelStyle: TextStyle(
                                    //fontFamily: FontFamily.inter,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
                                ),
                                initialValue: controller.getUsername(),
                                decoration: InputDecoration(
                                  errorMaxLines: 2,
                                  labelStyle: TextStyle(
                                    //fontFamily: FontFamily.inter,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                              Obx(
                                () => TextFormField(
                                  controller: controller
                                      .passwordTextEditController.value,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
                                  ),
                                  validator: (value) {
                                    if (value?.isNotEmpty ?? false) {
                                      if (value!.length < 8) {
                                        return 'min_size_field'.trParams({
                                          'name': 'password'.tr,
                                          'size': 8.toString(),
                                        });
                                      }
                                      if (RegExp(r'[\u0621-\u064A]',
                                              unicode: true)
                                          .hasMatch(value)) {
                                        return 'just_english_characters'
                                            .trParams({
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? Colors.grey
                                          : unselectedBottomBarItemColorLightTheme,
                                    ),
                                    hintText: '**********',
                                    filled: controller.focusNodes[1].hasFocus
                                        ? true
                                        : false,
                                    fillColor: ThemeController.to.getIsDarkMode
                                        ? bottomBarItemColorDarkTheme
                                            .withOpacity(0.1)
                                        : mainColor.withOpacity(0.1),
                                    label: Row(
                                      children: [
                                        Text('password'.tr),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.edit,
                                            color: controller
                                                    .focusNodes[1].hasFocus
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
                                      onPressed: () =>
                                          controller.setObscureText(),
                                      icon: Icon(
                                        controller.obscureText.value
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.visibility_off_outlined,
                                        color: ThemeController.to.getIsDarkMode
                                            ? unselectedBottomBarItemColorDarkTheme
                                            : eyeIconColor,
                                        size: 20,
                                      ),
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
                                        color: ThemeController.to.getIsDarkMode
                                            ? greyColor.withOpacity(.39)
                                            : strokeColor,
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
                          margin: EdgeInsets.only(
                              right: 17.w, left: 16.w, top: 15.h),
                          child: Text(
                            'portfolio'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ThemeController.to.getIsDarkMode
                                  ? bottomBarItemColorDarkTheme
                                  : mainColor,
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
                            color: ThemeController.to.getIsDarkMode
                                ? containerColorDarkTheme
                                : containerColorLightTheme,
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
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
                                ),
                                decoration: InputDecoration(
                                  errorMaxLines: 2,
                                  labelText: 'portfolio'.tr,
                                  labelStyle: TextStyle(
                                    //fontFamily: FontFamily.inter,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                                child: Scrollbar(
                                  // controller: controller.scrollController,
                                  // thumbVisibility: true,
                                  // thumbColor: mainColor,
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
                                        color: ThemeController.to.getIsDarkMode
                                            ? Colors.grey
                                            : unselectedBottomBarItemColorLightTheme,
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
                                          color:
                                              ThemeController.to.getIsDarkMode
                                                  ? greyColor.withOpacity(.39)
                                                  : strokeColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                        //fontFamily: FontFamily.inter,
                                        fontSize: 14.sp,
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
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
                                ),
                                decoration: InputDecoration(
                                  errorMaxLines: 2,
                                  labelText: 'plan'.tr,
                                  labelStyle: TextStyle(
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
                                ),
                                decoration: InputDecoration(
                                  errorMaxLines: 2,
                                  labelText: 'income'.tr,
                                  labelStyle: TextStyle(
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
                                ),
                                decoration: InputDecoration(
                                  errorMaxLines: 2,
                                  labelText: 'expected_return'.tr,
                                  labelStyle: TextStyle(
                                    //fontFamily: FontFamily.inter,
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
                                ),
                                decoration: InputDecoration(
                                  errorMaxLines: 2,
                                  labelText: 'currency'.tr,
                                  labelStyle: TextStyle(
                                    //fontFamily: FontFamily.inter,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                          margin: EdgeInsets.only(
                              right: 17.w, left: 16.w, top: 15.h),
                          child: Text(
                            'personal_information'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ThemeController.to.getIsDarkMode
                                  ? bottomBarItemColorDarkTheme
                                  : mainColor,
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
                            color: ThemeController.to.getIsDarkMode
                                ? containerColorDarkTheme
                                : containerColorLightTheme,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: controller
                                    .firstNameTextEditController.value,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
                                ),
                                validator: (value) {
                                  if (value != null) {
                                    if (value.isNotEmpty) {
                                      if (value
                                          .contains(new RegExp(r'[0-9]'))) {
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
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
                                  ),
                                  filled: controller.focusNodes[2].hasFocus
                                      ? true
                                      : false,
                                  fillColor: ThemeController.to.getIsDarkMode
                                      ? bottomBarItemColorDarkTheme
                                          .withOpacity(0.1)
                                      : mainColor.withOpacity(0.1),
                                  label: Row(
                                    children: [
                                      Text('first_name'.tr),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          color:
                                              controller.focusNodes[2].hasFocus
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
                                ),
                                validator: (value) {
                                  if (value != null) {
                                    if (value.isNotEmpty) {
                                      if (value
                                          .contains(new RegExp(r'[0-9]'))) {
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
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
                                  ),
                                  filled: controller.focusNodes[3].hasFocus
                                      ? true
                                      : false,
                                  fillColor: ThemeController.to.getIsDarkMode
                                      ? bottomBarItemColorDarkTheme
                                          .withOpacity(0.1)
                                      : mainColor.withOpacity(0.1),
                                  label: Row(
                                    children: [
                                      Text('last_name'.tr),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          color:
                                              controller.focusNodes[3].hasFocus
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        // height: 52.h,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                ThemeController.to.getIsDarkMode
                                                    ? greyColor.withOpacity(.39)
                                                    : strokeColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child:
                                              DropdownButtonFormField<String>(
                                            dropdownColor:
                                                ThemeController.to.getIsDarkMode
                                                    ? containerColorDarkTheme
                                                    : containerColorLightTheme,
                                            value: controller.getGenderSelect(),
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) {
                                              if (value?.isEmpty ?? true) {
                                                return 'required_field'
                                                    .trParams({
                                                  'name': 'gender'.tr,
                                                });
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              constraints: BoxConstraints(
                                                  minHeight: 52.h),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              errorBorder: UnderlineInputBorder(
                                                  borderSide:
                                                      BorderSide(width: 1)),
                                              focusedErrorBorder:
                                                  UnderlineInputBorder(
                                                      borderSide:
                                                          BorderSide(width: 1)),
                                            ),
                                            icon: Icon(Icons
                                                .keyboard_arrow_down_outlined),
                                            hint: Text(
                                              'gender'.tr,
                                              style: TextStyle(
                                                fontFamily: Get.locale
                                                            ?.languageCode
                                                            .compareTo('ar') ==
                                                        0
                                                    ? FontFamily.tajawal
                                                    : FontFamily.inter,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: ThemeController
                                                        .to.getIsDarkMode
                                                    ? unselectedBottomBarItemColorDarkTheme
                                                    : textFieldColor,
                                              ),
                                            ),
                                            style: TextStyle(
                                              //fontFamily: FontFamily.inter,
                                              fontFamily: Get
                                                          .locale?.languageCode
                                                          .compareTo('ar') ==
                                                      0
                                                  ? FontFamily.tajawal
                                                  : FontFamily.inter,
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w500,
                                              color: ThemeController
                                                      .to.getIsDarkMode
                                                  ? unselectedBottomBarItemColorDarkTheme
                                                  : textColor,
                                            ),
                                            isDense: true,
                                            isExpanded: true,
                                            items: [
                                              DropdownMenuItem(
                                                  child: Text("male".tr),
                                                  value: "male"),
                                              DropdownMenuItem(
                                                  child: Text("female".tr),
                                                  value: "female"),
                                            ],
                                            onChanged:
                                                controller.setGenderSelect,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 5,
                                    left: 5,
                                    child: Container(
                                      color: ThemeController.to.getIsDarkMode
                                          ? containerColorDarkTheme
                                          : containerColorLightTheme,
                                      height: 10,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Row(
                                        // mainAxisAlignment:
                                        // MainAxisAlignment.center,
                                        // mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            'gander'.tr,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: ThemeController
                                                      .to.getIsDarkMode
                                                  ? unselectedBottomBarItemColorDarkTheme
                                                  : unselectedBottomBarItemColorLightTheme,
                                            ),
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.edit,
                                              color: controller
                                                      .focusNodes[3].hasFocus
                                                  ? mainColor
                                                  : Colors.grey,
                                              size: 12,
                                            ),
                                          ),
                                          // Expanded(child: child)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 28.h),
                              Stack(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 0,
                                      ),
                                      Obx(
                                        () => Container(
                                            width: 400,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: controller
                                                        .natioalityRequired
                                                        .isTrue
                                                    ? Colors.amber
                                                    : ThemeController
                                                            .to.getIsDarkMode
                                                        ? greyColor
                                                            .withOpacity(.39)
                                                        : strokeColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                Get.to(() => CountriesPage());
                                              },
                                              child: SizedBox(
                                                  width: 400,
                                                  height: 55,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .nationalTextEditController
                                                            .value
                                                            .text,
                                                        style: TextStyle(
                                                          color: ThemeController
                                                                  .to
                                                                  .getIsDarkMode
                                                              ? unselectedBottomBarItemColorDarkTheme
                                                              : unselectedBottomBarItemColorLightTheme,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .keyboard_arrow_down_outlined,
                                                        color: controller
                                                                .natioalityRequired
                                                                .isTrue
                                                            ? Colors.amber
                                                            : Colors.black,
                                                      ),
                                                    ],
                                                  )),
                                            )),
                                      ),
                                    ],
                                  ),
                                  Obx(
                                    () => Positioned(
                                      top: -0,
                                      left: 5,
                                      child: Container(
                                        color: ThemeController.to.getIsDarkMode
                                            ? containerColorDarkTheme
                                            : containerColorLightTheme,
                                        height: 10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Row(
                                          // mainAxisAlignment:
                                          // MainAxisAlignment.center,
                                          // mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              'nationalty'.tr,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: controller
                                                        .natioalityRequired
                                                        .isTrue
                                                    ? Colors.amber
                                                    : ThemeController
                                                            .to.getIsDarkMode
                                                        ? unselectedBottomBarItemColorDarkTheme
                                                        : unselectedBottomBarItemColorLightTheme,
                                              ),
                                            ),
                                            IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.edit,
                                                color: controller
                                                        .natioalityRequired
                                                        .isTrue
                                                    ? Colors.amber
                                                    : controller.focusNodes[3]
                                                            .hasFocus
                                                        ? mainColor
                                                        : Colors.grey,
                                                size: 12,
                                              ),
                                            ),
                                            // Expanded(child: child)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 28.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      cursorColor: mainColor,
                                      controller: controller
                                          .passportTextEditController.value,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: ThemeController.to.getIsDarkMode
                                            ? unselectedBottomBarItemColorDarkTheme
                                            : unselectedBottomBarItemColorLightTheme,
                                      ),
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'required_field'.trParams({
                                            'name': 'passport_number'.tr,
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
                                          color: ThemeController
                                                  .to.getIsDarkMode
                                              ? Colors.grey
                                              : unselectedBottomBarItemColorLightTheme,
                                        ),
                                        filled:
                                            controller.focusNodes[4].hasFocus
                                                ? true
                                                : false,
                                        fillColor:
                                            ThemeController.to.getIsDarkMode
                                                ? bottomBarItemColorDarkTheme
                                                    .withOpacity(0.1)
                                                : mainColor.withOpacity(0.1),
                                        hintText: 'passport_number'.tr,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        label: Row(
                                          children: [
                                            Text('passport_number'.tr),
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
                                            color: controller.passport_status
                                                        .value ==
                                                    0
                                                ? Colors.amber
                                                : strokeColor,
                                            width: 1.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide(
                                            color:
                                                ThemeController.to.getIsDarkMode
                                                    ? greyColor.withOpacity(.39)
                                                    : strokeColor,
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Obx(() =>
                                      controller.passport_status.value == 2
                                          ? GestureDetector(
                                              onTap: () {
                                                print(controller.getTextValue(
                                                    controller
                                                        .passportTextEditController
                                                        .value
                                                        .text));
                                                print(controller.homeController
                                                    .getUser()!
                                                    .passport);
                                              },
                                              child: Icon(
                                                Icons.verified,
                                                color: successColor,
                                              ),
                                            )
                                          : SizedBox())
                                ],
                              ),
                              [2, 4].contains(controller.passport_status.value)
                                  ? SizedBox()
                                  : SizedBox(height: 28.h),
                              [2, 4].contains(controller.passport_status.value)
                                  ? SizedBox()
                                  : Obx(() => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          controller.passport_status.value == 0
                                              ? GestureDetector(
                                                  onTap: () => controller
                                                          .passportTextEditController
                                                          .value
                                                          .text
                                                          .isEmpty
                                                      ? controller.focusNodes[4]
                                                          .requestFocus()
                                                      : controller
                                                          .showImageSelectionPass(),
                                                  child: DottedBorder(
                                                    color: controller
                                                                .passport_status
                                                                .value ==
                                                            3
                                                        ? Colors.red[700]!
                                                        : controller.passport_status
                                                                    .value ==
                                                                0
                                                            ? inActiveTextColor
                                                            : controller.homeController
                                                                        .getUser()!
                                                                        .passport_required ==
                                                                    0
                                                                ? Colors
                                                                    .transparent
                                                                : inActiveTextColor,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 15,
                                                          horizontal: 20),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .upload_file_outlined,
                                                            color: controller
                                                                        .homeController
                                                                        .getUser()!
                                                                        .passport_required ==
                                                                    0
                                                                ? ThemeController
                                                                        .to
                                                                        .getIsDarkMode
                                                                    ? unselectedBottomBarItemColorDarkTheme
                                                                    : unselectedBottomBarItemColorLightTheme
                                                                : inActiveTextColor,
                                                            size: 15,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "upload_passport"
                                                                .tr,
                                                            style: TextStyle(
                                                              color: controller
                                                                          .homeController
                                                                          .getUser()!
                                                                          .passport_required ==
                                                                      0
                                                                  ? ThemeController
                                                                          .to
                                                                          .getIsDarkMode
                                                                      ? unselectedBottomBarItemColorDarkTheme
                                                                      : unselectedBottomBarItemColorLightTheme
                                                                  : inActiveTextColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : controller.passport_status
                                                          .value ==
                                                      1
                                                  ? DottedBorder(
                                                      color: inActiveTextColor,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 15,
                                                                horizontal: 20),
                                                        child: Text(
                                                          "processing_passport"
                                                              .tr,
                                                          style: TextStyle(
                                                              color:
                                                                  inActiveTextColor),
                                                        ),
                                                      ),
                                                    )
                                                  : controller.passport_status
                                                              .value ==
                                                          3
                                                      ? DottedBorder(
                                                          color:
                                                              Colors.red[700]!,
                                                          child: TextButton(
                                                              onPressed: () => controller
                                                                      .passportTextEditController
                                                                      .value
                                                                      .text
                                                                      .isEmpty
                                                                  ? controller
                                                                      .focusNodes[
                                                                          4]
                                                                      .requestFocus()
                                                                  : controller
                                                                      .showImageSelectionPass(),
                                                              child: Text(
                                                                "rejected_passport"
                                                                    .tr,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .red[
                                                                        700],
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              )),
                                                        )
                                                      : SizedBox(),
                                          controller.getFilePass().path.isEmpty
                                              ? controller.passport_image
                                                          .value ==
                                                      EndPoints.passPortPath
                                                  ? TextImageExaption(
                                                      controller)
                                                  : controller.passport_status
                                                              .value ==
                                                          0
                                                      ? TextImageExaption(
                                                          controller)
                                                      : controller
                                                              .sizeOfImageExaption
                                                              .value
                                                              .isEmpty
                                                          ? GestureDetector(
                                                              onTap: () => Get.to(
                                                                  () => ShowImage(
                                                                      isfile:
                                                                          false,
                                                                      imagePath: controller
                                                                          .passport_image
                                                                          .value)),
                                                              child: Container(
                                                                width: 80,
                                                                height: 80,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(controller
                                                                            .passport_image
                                                                            .value),
                                                                        fit: BoxFit
                                                                            .fill)),
                                                              ),
                                                            )
                                                          : TextImageExaption(
                                                              controller)

                                              //  Image.network(
                                              //     controller
                                              //         .passport_image.value,

                                              //     fit: BoxFit.cover)
                                              : controller.sizeOfImageExaption
                                                      .value.isEmpty
                                                  ? GestureDetector(
                                                      onTap: () => Get.to(() =>
                                                          ShowImage(
                                                              isfile: true,
                                                              imagePath: controller
                                                                  .getFilePass()
                                                                  .path)),
                                                      child: Container(
                                                        width: 80,
                                                        height: 80,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            image: DecorationImage(
                                                                image: FileImage(
                                                                    controller
                                                                        .getFilePass()),
                                                                fit: BoxFit
                                                                    .fill)),
                                                      ),
                                                    )
                                                  : TextImageExaption(
                                                      controller)

                                          //  Image.file(
                                          //     controller.getFilePass(),
                                          //     width: 80,
                                          //     height: 80,
                                          //     fit: BoxFit.cover,
                                          //   ),
                                        ],
                                      )),
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
                                        color: ThemeController.to.getIsDarkMode
                                            ? unselectedBottomBarItemColorDarkTheme
                                            : unselectedBottomBarItemColorLightTheme,
                                      ),
                                      focusNode: FocusScopeNode(
                                          canRequestFocus: false),
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
                                          color: ThemeController
                                                  .to.getIsDarkMode
                                              ? Colors.grey
                                              : unselectedBottomBarItemColorLightTheme,
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
                                            color:
                                                ThemeController.to.getIsDarkMode
                                                    ? greyColor.withOpacity(.39)
                                                    : strokeColor,
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
                                      controller: controller
                                          .cityTextEditController.value,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: ThemeController.to.getIsDarkMode
                                            ? unselectedBottomBarItemColorDarkTheme
                                            : unselectedBottomBarItemColorLightTheme,
                                      ),
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'required_field'.trParams({
                                            'name': 'city'.tr,
                                          });
                                        }
                                        return null;
                                      },
                                      focusNode: controller.focusNodes[5],
                                      decoration: InputDecoration(
                                        errorMaxLines: 2,
                                        labelStyle: TextStyle(
                                          //fontFamily: FontFamily.inter,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: ThemeController
                                                  .to.getIsDarkMode
                                              ? Colors.grey
                                              : unselectedBottomBarItemColorLightTheme,
                                        ),
                                        filled:
                                            controller.focusNodes[5].hasFocus
                                                ? true
                                                : false,
                                        fillColor:
                                            ThemeController.to.getIsDarkMode
                                                ? bottomBarItemColorDarkTheme
                                                    .withOpacity(0.1)
                                                : mainColor.withOpacity(0.1),
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
                                            color:
                                                ThemeController.to.getIsDarkMode
                                                    ? greyColor.withOpacity(.39)
                                                    : strokeColor,
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
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
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
                                  label: Row(
                                    children: [
                                      Text(
                                        'phone_number'.tr,
                                        style: TextStyle(
                                          color: ThemeController
                                                  .to.getIsDarkMode
                                              ? Colors.grey
                                              : unselectedBottomBarItemColorLightTheme,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          color:
                                              controller.focusNodes[3].hasFocus
                                                  ? mainColor
                                                  : Colors.grey,
                                          size: 17,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                          margin: EdgeInsets.only(
                              right: 17.w, left: 16.w, top: 15.h),
                          child: Text(
                            'banking_details'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ThemeController.to.getIsDarkMode
                                  ? bottomBarItemColorDarkTheme
                                  : mainColor,
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
                            color: ThemeController.to.getIsDarkMode
                                ? containerColorDarkTheme
                                : containerColorLightTheme,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                cursorColor: mainColor,
                                controller:
                                    controller.bankNameTextEditController.value,
                                focusNode: controller.focusNodes[6],
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
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
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
                                  ),
                                  filled: controller.focusNodes[6].hasFocus
                                      ? true
                                      : false,
                                  fillColor: ThemeController.to.getIsDarkMode
                                      ? bottomBarItemColorDarkTheme
                                          .withOpacity(0.1)
                                      : mainColor.withOpacity(0.1),
                                  label: Row(
                                    children: [
                                      Text(
                                        'bank_name'.tr,
                                        style: TextStyle(
                                          color: ThemeController
                                                  .to.getIsDarkMode
                                              ? Colors.grey
                                              : unselectedBottomBarItemColorLightTheme,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          color:
                                              controller.focusNodes[6].hasFocus
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                                style: TextStyle(
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
                                ),
                                cursorColor: mainColor,
                                controller: controller
                                    .bankAccountNumberTextEditController.value,
                                focusNode: controller.focusNodes[7],
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
                                      if (!RegExp(r"^[0-9]+$")
                                          .hasMatch(value)) {
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
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
                                    //fontFamily: FontFamily.inter,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  filled: controller.focusNodes[7].hasFocus
                                      ? true
                                      : false,
                                  fillColor: ThemeController.to.getIsDarkMode
                                      ? bottomBarItemColorDarkTheme
                                          .withOpacity(0.1)
                                      : mainColor.withOpacity(0.1),
                                  label: Row(
                                    children: [
                                      Text(
                                        'bank_account_number'.tr,
                                        style: TextStyle(
                                          color: ThemeController
                                                  .to.getIsDarkMode
                                              ? Colors.grey
                                              : unselectedBottomBarItemColorLightTheme,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          color:
                                              controller.focusNodes[7].hasFocus
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
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
                                focusNode: controller.focusNodes[8],
                                decoration: InputDecoration(
                                  errorMaxLines: 2,
                                  labelStyle: TextStyle(
                                    //fontFamily: FontFamily.inter,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
                                  ),
                                  filled: controller.focusNodes[8].hasFocus
                                      ? true
                                      : false,
                                  fillColor: ThemeController.to.getIsDarkMode
                                      ? bottomBarItemColorDarkTheme
                                          .withOpacity(0.1)
                                      : mainColor.withOpacity(0.1),
                                  label: Row(
                                    children: [
                                      Text(
                                        'bank_account_name'.tr,
                                        style: TextStyle(
                                          color: ThemeController
                                                  .to.getIsDarkMode
                                              ? Colors.grey
                                              : unselectedBottomBarItemColorLightTheme,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          color:
                                              controller.focusNodes[8].hasFocus
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                                focusNode: controller.focusNodes[9],
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : unselectedBottomBarItemColorLightTheme,
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
                                    color: ThemeController.to.getIsDarkMode
                                        ? Colors.grey
                                        : unselectedBottomBarItemColorLightTheme,
                                  ),
                                  filled: controller.focusNodes[9].hasFocus
                                      ? true
                                      : false,
                                  fillColor: ThemeController.to.getIsDarkMode
                                      ? bottomBarItemColorDarkTheme
                                          .withOpacity(0.1)
                                      : mainColor.withOpacity(0.1),
                                  label: Row(
                                    children: [
                                      Text(
                                        'iban'.tr,
                                        style: TextStyle(
                                          color: ThemeController
                                                  .to.getIsDarkMode
                                              ? Colors.grey
                                              : unselectedBottomBarItemColorLightTheme,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          color:
                                              controller.focusNodes[9].hasFocus
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? greyColor.withOpacity(.39)
                                          : strokeColor,
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
                              ? Center(child: LoadingLogoWidget())
                              : Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 17.w),
                                  child: TextButton(
                                    onPressed: controller.onUpdateButtonClick,
                                    style: TextButton.styleFrom(
                                      minimumSize: const Size.fromHeight(50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      // primary: mainColor,
                                      backgroundColor:
                                          ThemeController.to.getIsDarkMode
                                              ? mainColorDarkTheme
                                              : mainColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  child: LoadingLogoWidget(
                                  width: 60,
                                ))
                              : Container(
                                  margin:
                                      EdgeInsets.fromLTRB(17.w, 12.h, 16.w, 0),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: controller
                                        .showDeleteAccountReasonDialog,
                                    child: controller.getIsDeleteLoading()
                                        ? Center(
                                            child: LoadingLogoWidget(
                                            width: 60,
                                          ))
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Iconify(
                                                Ic.round_delete_outline,
                                                size: 20,
                                                color: secondaryColor,
                                              ),
                                              SizedBox(width: 8.w),
                                              Text(
                                                'delete_account'.tr,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: secondaryColor,
                                                  //fontFamily: FontFamily.inter,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                          //  Container(
                          //     margin: EdgeInsets.symmetric(horizontal: 17.w),
                          //     child: TextButton(
                          //       onPressed:
                          //           controller.showDeleteAccountReasonDialog,
                          //       style: TextButton.styleFrom(
                          //         minimumSize: const Size.fromHeight(50),
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //         // primary: mainColor,
                          //         backgroundColor: secondaryColor,
                          //       ),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: [
                          //           Text(
                          //             'delete_account'.tr,
                          //             style: TextStyle(
                          //               //fontFamily: FontFamily.inter,
                          //               fontSize: 13.sp,
                          //               fontWeight: FontWeight.w600,
                          //               color: Colors.white,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
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
      ),
    );
  }

  Expanded TextImageExaption(EditProfileController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          controller.sizeOfImageExaption.value,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red),
        ),
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
                    child: LoadingLogoWidget(
                    width: 70,
                  ))
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
                              color: ThemeController.to.getIsDarkMode
                                  ? bottomBarItemColorDarkTheme
                                  : mainColor,
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
                                      color: ThemeController.to.getIsDarkMode
                                          ? bottomBarItemColorDarkTheme
                                          : mainColor,
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
