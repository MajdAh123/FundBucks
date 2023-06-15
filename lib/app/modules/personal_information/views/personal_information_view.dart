import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/personal_information_controller.dart';

class PersonalInformationView extends GetView<PersonalInformationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.to.getIsDarkMode
          ? backgroundColorDarkTheme
          : backgroundColorLightTheme,
      body: LogoCardWidget(
        cardHeight: 600.h,
        title: '3 / 3',
        subTitle: 'personal_information'.tr,
        content: Container(
          margin: EdgeInsets.only(right: 16.w, left: 16.w, top: 45.h),
          child: Obx(
            () => Form(
              key: controller.getFormKey(),
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: controller.firstnameTextEditController.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      hintText: 'first_name'.tr,
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
                        color: ThemeController.to.getIsDarkMode
                            ? unselectedBottomBarItemColorDarkTheme
                            : null,
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
                    controller: controller.lastnameTextEditController.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      hintText: 'last_name'.tr,
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
                        color: ThemeController.to.getIsDarkMode
                            ? unselectedBottomBarItemColorDarkTheme
                            : null,
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
                    controller: controller.emailTextEditController.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'required_field'.trParams({
                          'name': 'email'.tr,
                        });
                      }
                      if (!GetUtils.isEmail(value ?? '')) {
                        return 'input_valid_email'.trParams({
                          'name': 'email'.tr,
                        });
                      }
                      return null;
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      hintText: 'email'.tr,
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
                        color: ThemeController.to.getIsDarkMode
                            ? unselectedBottomBarItemColorDarkTheme
                            : null,
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
                    controller: controller.countryTextEditController.value,
                    readOnly: true,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'required_field'.trParams({
                          'name': 'country'.tr,
                        });
                      }
                      return null;
                    },
                    cursorColor: mainColor,
                    focusNode: FocusScopeNode(canRequestFocus: false),
                    onTap: () async {
                      controller.showCountryModal();
                      FocusNode(canRequestFocus: false);
                    },
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      hintText: 'country'.tr,
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
                        color: ThemeController.to.getIsDarkMode
                            ? unselectedBottomBarItemColorDarkTheme
                            : null,
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          // height: 52.h,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ThemeController.to.getIsDarkMode
                                  ? greyColor.withOpacity(.39)
                                  : strokeColor,
                            ),
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
                                constraints: BoxConstraints(minHeight: 48.h),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                // errorBorder: UnderlineInputBorder(
                                //     borderSide: BorderSide(width: 0)),
                                // focusedErrorBorder: UnderlineInputBorder(
                                //     borderSide: BorderSide(width: 0)),
                              ),
                              icon: Icon(Icons.keyboard_arrow_down_outlined),
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
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : textFieldColor,
                                ),
                              ),
                              style: TextStyle(
                                //fontFamily: FontFamily.inter,
                                fontFamily:
                                    Get.locale?.languageCode.compareTo('ar') ==
                                            0
                                        ? FontFamily.tajawal
                                        : FontFamily.inter,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: ThemeController.to.getIsDarkMode
                                    ? unselectedBottomBarItemColorDarkTheme
                                    : textColor,
                              ),
                              isDense: true,
                              isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                    child: Text("male".tr), value: "male"),
                                DropdownMenuItem(
                                    child: Text("female".tr), value: "female"),
                              ],
                              onChanged: controller.setGenderSelect,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: TextFormField(
                          controller: controller.cityTextEditController.value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          cursorColor: mainColor,
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            hintText: 'city'.tr,
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
                              color: ThemeController.to.getIsDarkMode
                                  ? unselectedBottomBarItemColorDarkTheme
                                  : null,
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
                  SizedBox(height: 14.h),
                  TextFormField(
                    controller: controller.phoneNumberController.value,
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
                          controller.countryDialCode.value + (value ?? ''))) {
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
                        color: ThemeController.to.getIsDarkMode
                            ? unselectedBottomBarItemColorDarkTheme
                            : null,
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
                  SizedBox(height: 8.h),
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 3.1.h),
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.r))),
                            value: controller.agreeToTerms.value,
                            onChanged: controller.setAgreeToTerms,
                            activeColor: mainColor,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          'agree_to_terms'.tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: ThemeController.to.getIsDarkMode
                                ? unselectedBottomBarItemColorDarkTheme
                                : textFieldColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(
                            '/webview',
                            arguments: ['terms_and_conditions'.tr, 1],
                          ),
                          child: Text(
                            'terms_and_conditions'.tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeController.to.getIsDarkMode
                                  ? bottomBarItemColorDarkTheme
                                  : mainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    controller.errorText.value,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  controller.getIsLoading()
                      ? Center(
                          child: SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            controller.onContinueButtonClick();
                          },
                          style: TextButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
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
                                'sign_up'.tr,
                                style: TextStyle(
                                  //fontFamily: FontFamily.inter,
                                  fontSize: 13.sp,
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
                  SizedBox(height: 17.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
