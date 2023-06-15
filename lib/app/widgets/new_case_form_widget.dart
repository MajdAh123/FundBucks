import 'package:app/app/modules/home/controllers/contact_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NewCaseFormWidget extends GetView<ContactController> {
  const NewCaseFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.getIsLoading()
          ? Center(
              child: SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: controller.getFormKey(),
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  TextFormField(
                    cursorColor: mainColor,
                    controller: controller.titleTextEditingController.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'required_field'.trParams({
                          'name': 'subject'.tr,
                        });
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      hintText: 'subject'.tr,
                      filled: true,
                      fillColor: ThemeController.to.getIsDarkMode
                          ? containerColorDarkTheme
                          : containerColorLightTheme,
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
                  SizedBox(height: 12.h),
                  TextFormField(
                    cursorColor: mainColor,
                    controller:
                        controller.descriptionTextEditingController.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.done,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'required_field'.trParams({
                          'name': 'description'.tr,
                        });
                      }
                      if (controller.getCounter() > 250) {
                        return 'too_long'.tr;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      controller.setCounter(value.length);
                    },
                    maxLines: 9,
                    decoration: InputDecoration(
                      errorMaxLines: 2,
                      hintText: 'description'.tr,
                      counter: Text(
                        controller.getDescriptionCounter(),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: controller.getCounter() > 250
                              ? glowColor
                              : textFieldColor,
                        ),
                      ),
                      filled: true,
                      fillColor: ThemeController.to.getIsDarkMode
                          ? containerColorDarkTheme
                          : containerColorLightTheme,
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
                  SizedBox(height: 40.h),
                  Container(
                    margin: EdgeInsets.only(left: 16.w, right: 15.w),
                    child: TextButton(
                      onPressed: controller.onCreateButtonClick,
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
                      child: Text(
                        'create'.tr,
                        style: TextStyle(
                          //fontFamily: FontFamily.inter,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  // did_you_search_faq
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'did_you_search_faq'.tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        // SizedBox(width: 5.w),
                        GestureDetector(
                          onTap: () => Get.toNamed('/support-card'),
                          child: Text(
                            'faq'.tr,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: ThemeController.to.getIsDarkMode
                                  ? bottomBarItemColorDarkTheme
                                  : mainColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 1.5.w),
                        Text(
                          'question_mark'.tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
