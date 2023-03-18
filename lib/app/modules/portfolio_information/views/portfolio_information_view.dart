import 'dart:io';
import 'dart:ui';

import 'package:app/app/data/models/models.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/portfolio_information_controller.dart';

class PortfolioInformationView extends GetView<PortfolioInformationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: LogoCardWidget(
        cardHeight: 480.h,
        title: '2 / 3',
        subTitle: 'portfolio_information'.tr,
        content: Container(
          margin: EdgeInsets.only(right: 16.w, left: 16.w, top: 45.h),
          child: Obx(
            () => controller.getIsLoading()
                ? Center(
                    child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 30.w, vertical: 30.w),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.h,
                      child: CircularProgressIndicator(),
                    ),
                  ))
                : Form(
                    key: controller.getFormKey(),
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // height: 52.h,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: strokeColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              enableFeedback: true,
                              elevation: 12,
                              value: controller.getPortfolioSelect(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                constraints: BoxConstraints(minHeight: 52.h),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                // errorBorder: UnderlineInputBorder(
                                //     borderSide: BorderSide(width: 0)),
                                // focusedErrorBorder: UnderlineInputBorder(
                                //     borderSide: BorderSide(width: 0)),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'required_field'.trParams({
                                    'name': 'portfolio'.tr,
                                  });
                                }
                                return null;
                              },
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              hint: Text(
                                'portfolio'.tr,
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
                              items: controller
                                  .getPlans()
                                  .map(
                                    (Plan e) => DropdownMenuItem<String>(
                                      child: Text(
                                        Functions.getTranslate(
                                            enValue: e.enName!,
                                            arValue: e.name!),
                                      ),
                                      value: Functions.getTranslate(
                                          enValue: e.enName!,
                                          arValue: e.name!),
                                    ),
                                  )
                                  .toList(),
                              onChanged: controller.setPortfolioSelect,
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
                              controller: controller
                                  .planDetailsTextEditingController.value,
                              cursorColor: mainColor,
                              readOnly: true,
                              maxLines: 8,
                              style: TextStyle(
                                color: softGreyColor,
                                fontSize: 13.sp,
                                fontStyle: FontStyle.normal,
                              ),
                              textAlign: TextAlign.justify,
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                labelText: 'details'.tr,
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
                                labelStyle: TextStyle(
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
                        ),
                        SizedBox(height: 14.h),
                        TextFormField(
                          controller: controller
                              .planInterestTypeTextEditingController.value,
                          cursorColor: mainColor,
                          readOnly: true,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            labelText: 'plan'.tr,
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
                            labelStyle: TextStyle(
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
                          controller: controller
                              .planWithdrawDaysTextEditingController.value,
                          cursorColor: mainColor,
                          readOnly: true,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            labelText: 'income'.tr,
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
                            labelStyle: TextStyle(
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
                          controller: controller
                              .planExepectedReturnTextEditinController.value,
                          cursorColor: mainColor,
                          readOnly: true,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            labelText: 'expected_return'.tr,
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
                            labelStyle: TextStyle(
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
                        Container(
                          // height: 52.h,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: strokeColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              enableFeedback: true,
                              elevation: 12,
                              value: controller.getCurrencySelect(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                label: Text(
                                  'currency'.tr,
                                  style: TextStyle(
                                    fontFamily: Get.locale?.languageCode
                                                .compareTo('ar') ==
                                            0
                                        ? FontFamily.tajawal
                                        : FontFamily.inter,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    // color: textFieldColor,
                                  ),
                                ),
                                constraints: BoxConstraints(minHeight: 52.h),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                // errorBorder: UnderlineInputBorder(
                                //     borderSide: BorderSide(width: 0)),
                                // focusedErrorBorder: UnderlineInputBorder(
                                //     borderSide: BorderSide(width: 0)),
                              ),
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'required_field'.trParams({
                                    'name': 'currency'.tr,
                                  });
                                }
                                return null;
                              },
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              hint: Text(
                                'currency'.tr,
                                style: TextStyle(
                                  fontFamily: Get.locale?.languageCode
                                              .compareTo('ar') ==
                                          0
                                      ? FontFamily.tajawal
                                      : FontFamily.inter,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  // color: textFieldColor,
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
                              items: controller
                                  .getCurrencies()
                                  .map(
                                    (Currency e) => DropdownMenuItem<String>(
                                      child: Text(
                                        Get.locale?.languageCode
                                                    .compareTo('ar') ==
                                                0
                                            ? e.currencyId!
                                            : e.currencySign!,
                                      ),
                                      value: e.currencyId!,
                                    ),
                                  )
                                  .toList(),
                              onChanged: controller.setCurrencySelect,
                            ),
                          ),
                        ),
                        SizedBox(height: 48.h),
                        TextButton(
                          onPressed: () {
                            controller.onContinueButtonClick();

                            // Get.toNamed('/personal-information');
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (_) => const PersonalInformationScreen()));
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
                        SizedBox(height: 36.h),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
