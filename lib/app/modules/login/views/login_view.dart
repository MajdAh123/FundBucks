import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: ThemeController.to.getIsDarkMode
            ? backgroundColorDarkTheme
            : backgroundColorLightTheme,
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LogoCardWidget(
                cardHeight: 480.h,
                subTitle: 'sign_in_to_you_account'.tr,
                content: Container(
                  margin: EdgeInsets.only(right: 16.w, left: 16.w, top: 45.h),
                  child: Form(
                    key: controller.getFormKey(),
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          controller: controller
                              .usernameOrEmailTextEditingController.value,
                          cursorColor: mainColor,
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
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'username_or_email'.tr,
                            errorMaxLines: 2,
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
                              controller.passwordTextEditingController.value,
                          cursorColor: mainColor,
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
                            return null;
                          },
                          obscureText: controller.obscureInput.value,
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            labelStyle: TextStyle(
                              //fontFamily: FontFamily.inter,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => controller.setObscureInput(),
                              icon: Icon(
                                !controller.obscureInput.value
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.visibility_off_outlined,
                                color: ThemeController.to.getIsDarkMode
                                    ? eyeIconColorDarkTheme
                                    : eyeIconColor,
                                size: 20,
                              ),
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
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 3.1.h),
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.r))),
                                value: controller.getSaveLogin(),
                                onChanged: controller.setSaveLogin,
                                activeColor: ThemeController.to.getIsDarkMode
                                    ? mainColorDarkTheme
                                    : mainColor,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Text('remember_me'.tr,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
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
                                  backgroundColor:
                                      ThemeController.to.getIsDarkMode
                                          ? mainColorDarkTheme
                                          : mainColor,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'sign_in'.tr,
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
                        SizedBox(height: 21.h),
                        Center(
                          child: InkWell(
                            onTap: () => Get.toNamed('/find-account'),
                            child: Text(
                              'lost_your_password'.tr,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: mainColor,
                                //fontFamily: FontFamily.inter,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        !controller.getCreateAccountChoice()
                            ? SizedBox.shrink()
                            : Container(
                                margin: EdgeInsets.symmetric(vertical: 5.h),
                                child: Divider(),
                              ),
                        !controller.getCreateAccountChoice()
                            ? SizedBox.shrink()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'dont_have_an_account'.tr,
                                    style: TextStyle(
                                      //fontFamily: FontFamily.inter,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  InkWell(
                                    onTap: () => Get.toNamed('/create-account'),
                                    child: Text(
                                      'sign_up_now'.tr,
                                      style: TextStyle(
                                        //fontFamily: FontFamily.inter,
                                        color: mainColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                            height: !controller.getCreateAccountChoice()
                                ? 25.h
                                : 1.h),
                      ],
                    ),
                  ),
                ),
              ),
              // footer: Text('adw'),
              SizedBox(height: 8.h),
              InkWell(
                onTap: () => controller.changeLanguage(
                    Get.locale?.languageCode.compareTo('ar') == 0
                        ? 'en'
                        : 'ar'),
                child: Text(
                  Get.locale?.languageCode.compareTo('ar') == 0
                      ? 'English'
                      : 'العربية',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              // SizedBox(height: 10.h),
              // InkWell(
              //   onTap: () => controller.changeTheme(),
              //   child: Text(
              //     !ThemeController.to.getIsDarkMode
              //         ? 'Dark Mode'
              //         : 'Light Mode',
              //     style: TextStyle(
              //       fontSize: 13.sp,
              //       fontWeight: FontWeight.w500,
              //       color: Colors.grey,
              //     ),
              //   ),
              // ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

// InkWell(
//                 onTap: () => controller.changeLanguage(
//                     Get.locale?.languageCode.compareTo('ar') == 0
//                         ? 'en'
//                         : 'ar'),
//                 child: Text(
//                   Get.locale?.languageCode.compareTo('ar') == 0
//                       ? 'English'
//                       : 'العربية',
//                   style: TextStyle(
//                     fontSize: 13.sp,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ),
