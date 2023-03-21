import 'dart:io';

import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/create_account_controller.dart';

class CreateAccountView extends GetView<CreateAccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: LogoCardWidget(
        cardHeight: 514.h,
        title: '1 / 3',
        subTitle: 'create_new_account'.tr,
        content: Container(
          margin: EdgeInsets.only(right: 16.w, left: 16.w, top: 45.h),
          child: Obx(
            () => Form(
              key: controller.getFormKey(),
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: controller.showImageSelection,
                        child: Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20.h),
                                child: !controller.getFilePath().isEmpty
                                    ? CircleAvatar(
                                        backgroundImage:
                                            FileImage(controller.getFile()),
                                        radius: 50.r,
                                      )
                                    : Assets.images.svg.user.svg(
                                        width: 96.w,
                                        height: 96.h,
                                        fit: BoxFit.contain,
                                      ),
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  width: 25.w,
                                  height: 25.w,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: 1,
                                    child: Icon(Icons.edit,
                                        size: 12, color: mainColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller:
                        controller.usernameTextEditingController.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'required_field'.trParams({
                          'name': 'username'.tr,
                        });
                      }
                      if (value?.contains(' ') ?? true) {
                        return 'no_space_field'.trParams({
                          'name': 'username'.tr,
                        });
                      }
                      if (value!.length < 6) {
                        return 'min_size_field'.trParams({
                          'name': 'username'.tr,
                          'size': 6.toString(),
                        });
                      }
                      if (RegExp(r'[\u0621-\u064A]', unicode: true)
                          .hasMatch(value)) {
                        return 'just_english_characters'.trParams({
                          'name': 'username'.tr,
                        });
                      }
                      if (controller.getIsUsernameTaken()) {
                        return 'username_is_already_taken'.tr;
                      }
                      // username_is_already_taken
                      return null;
                    },
                    cursorColor: mainColor,
                    onChanged: controller.checkUsername,
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      labelStyle: TextStyle(
                        //fontFamily: FontFamily.inter,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      suffixIcon: controller.getIsCheckUsernameLoading()
                          ? Container(
                              width: 15.w,
                              height: 15.h,
                              margin: Functions.getSpacingBasedOnLang(10.w),
                              child: CircularProgressIndicator(
                                strokeWidth: 3.w,
                              ),
                            )
                          : controller.isUsernameLessThan()
                              ? null
                              : controller.getIsUsernameTaken()
                                  ? Container(
                                      width: 15.w,
                                      height: 15.h,
                                      margin: Functions.getSpacingBasedOnLang(
                                          10.w),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                    )
                                  : Container(
                                      width: 15.w,
                                      height: 15.h,
                                      margin: Functions.getSpacingBasedOnLang(
                                          10.w),
                                      child: Icon(
                                        Icons.check_circle_outline_rounded,
                                        color: successColor,
                                      ),
                                    ),
                      suffixIconConstraints:
                          BoxConstraints(maxHeight: 30.h, maxWidth: 30.w),
                      hintText: 'username'.tr,
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
                  SizedBox(height: 14.h),
                  TextFormField(
                    controller:
                        controller.passwordTextEditingController.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    cursorColor: mainColor,
                    obscureText: controller.getIsObscureText(),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'required_field'.trParams({
                          'name': 'password'.tr,
                        });
                      }
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
                      return null;
                    },
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      labelStyle: TextStyle(
                        //fontFamily: FontFamily.inter,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      suffixIcon: IconButton(
                        onPressed: controller.setIsObscureText,
                        icon: Icon(
                            !controller.getIsObscureText()
                                ? Icons.remove_red_eye_outlined
                                : Icons.visibility_off_outlined,
                            color: eyeIconColor,
                            size: 20),
                      ),
                      hintText: 'password'.tr,
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
                  SizedBox(height: 14.h),
                  TextFormField(
                    controller:
                        controller.confirmPasswordTextEditingController.value,
                    cursorColor: mainColor,
                    obscureText:
                        controller.getIsObscureTextForPasswordConfirmation(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'required_field'.trParams({
                          'name': 'password_confirmation'.tr,
                        });
                      }
                      if (controller.passwordTextEditingController.value.text
                              .compareTo(value ?? '') !=
                          0) {
                        return 'password_confirmation_error'.tr;
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
                      hintText: 'password_confirmation'.tr,
                      suffixIcon: IconButton(
                        onPressed: controller
                            .setIsObscureTextForPasswordConfirmation,
                        icon: Icon(
                            !controller
                                    .getIsObscureTextForPasswordConfirmation()
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
                  SizedBox(height: 45.h),
                  TextButton(
                    onPressed: () {
                      controller.onContinueButtonClick();
                    },
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
                          'continue_text'.tr,
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
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
