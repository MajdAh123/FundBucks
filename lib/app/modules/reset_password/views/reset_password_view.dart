import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.to.getIsDarkMode
          ? backgroundColorDarkTheme
          : backgroundColorLightTheme,
      body: LogoCardWidget(
        cardHeight: 480.h,
        subTitle: 'reset_password'.tr,
        content: Container(
          margin: EdgeInsets.only(right: 16.w, left: 16.w, top: 45.h),
          child: Obx(
            () => Form(
              key: controller.getFormKey(),
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    controller: controller.passwordTextEditingController.value,
                    cursorColor: mainColor,
                    obscureText: controller.getIsObscureTextForPassword(),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
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
                      hintText: 'password'.tr,
                      suffixIcon: IconButton(
                        onPressed: controller.setIsObscureTextForPassword,
                        icon: Icon(
                            !controller.getIsObscureTextForPassword()
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
                      hintText: 'password_confirmation'.tr,
                      suffixIcon: IconButton(
                        onPressed:
                            controller.setIsObscureTextForPasswordConfirmation,
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
                  SizedBox(height: 20.h),
                  controller.getIsLoading()
                      ? Center(
                          child: SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(),
                        ))
                      : TextButton(
                          onPressed: () {
                            controller.onContinueButtonClick();
                          },
                          style: TextButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            // primary: mainColor,
                            backgroundColor: ThemeController.to.getIsDarkMode
                                ? mainColorDarkTheme
                                : mainColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'reset'.tr,
                                style: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                  SizedBox(height: 38.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
