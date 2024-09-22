import 'dart:io';

import 'package:app/app/data/models/models.dart';
import 'package:app/app/modules/home/controllers/operation_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:timezone/standalone.dart' as tz;

class DepositFormWidget extends GetView<OperationController> {
  const DepositFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ...controller
              .getGateways()
              .map(
                (e) => DepositSelectGatewayItemWidget(
                  alias: e.alias ?? e.id.toString(),
                  selected: controller.getSelectedGatewayIndex(),
                  onClick: controller.setSelectedGateway,
                  title: Get.locale?.languageCode.compareTo('ar') == 0
                      ? (e.name ?? '')
                      : (e.enName ?? ''),
                  icon: controller.getIconBasedOnGateway(e.code),
                  id: e.id!,
                ),
              )
              .toList(),
          // SizedBox(height: 5.h),
          controller.getGateways().isEmpty
              ? Container(
                  margin: EdgeInsets.only(top: 15.h),
                  child: Text(
                    'no_gateways_found'.tr,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: ThemeController.to.getIsDarkMode
                          ? unselectedBottomBarItemColorDarkTheme
                          : unselectedBottomBarItemColorLightTheme,
                    ),
                  ),
                )
              : controller.getSelectedGatewayIndex()?.isEmpty ?? true
                  ? SizedBox.shrink()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (controller.getSelectedGatewayCode() == 101) ...[
                          SizedBox(height: 40.h),
                          DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(8),
                            padding: EdgeInsets.all(6.h),
                            color: ThemeController.to.getIsDarkMode
                                ? mainColorDarkTheme
                                : mainColor,
                            strokeWidth: 2.h,
                            child: InkWell(
                              onTap: controller.showImageSelection,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: 343.w,
                                  height: 109.h,
                                  child: !controller.getFilePath().isEmpty
                                      ? Stack(
                                          children: [
                                            Positioned.fill(
                                              child: Image.file(
                                                controller.getFile(),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Positioned(
                                                top: 0,
                                                right: 10.w,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.cancel_rounded,
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    controller.setImageFilePath(
                                                        File(''));
                                                    controller.setFilePath('');
                                                  },
                                                ))
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            // SizedBox(height: 14.h),
                                            Expanded(
                                                flex: 2, child: SizedBox()),
                                            Assets.images.svg.uploadIcon.svg(
                                              width: 20.w,
                                              height: 24.h,
                                              color: ThemeController
                                                      .to.getIsDarkMode
                                                  ? bottomBarItemColorDarkTheme
                                                  : mainColor,
                                            ),
                                            Expanded(
                                                flex: 1, child: SizedBox()),

                                            // SizedBox(height: 7.h),
                                            Text(
                                              'inform_us_text'.tr,
                                              style: TextStyle(
                                                //fontFamily: FontFamily.inter,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: ThemeController
                                                        .to.getIsDarkMode
                                                    ? unselectedBottomBarItemColorDarkTheme
                                                    : textFieldColor,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                        SizedBox(height: 32.h),
                        TextFormField(
                          cursorColor: ThemeController.to.getIsDarkMode
                              ? mainColorDarkTheme
                              : mainColor,
                          controller: controller
                              .getDepositAmountTextEditingController(),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: false,
                          ),
                          inputFormatters: [
                            DigitPersianFormatter(),
                          ],
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: ThemeController.to.getIsDarkMode
                                ? unselectedBottomBarItemColorDarkTheme
                                : unselectedBottomBarItemColorLightTheme,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'required_field'.trParams({
                                'name': 'amount'.tr,
                              });
                            }
                            double? parsedValue = double.tryParse(value!);
                            if (parsedValue == null) {
                              return 'required_field'.trParams({
                                'name': 'amount'.tr,
                              });
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            errorText:
                                controller.depositAmountError.value.isEmpty
                                    ? null
                                    : controller.depositAmountError.value,

                            errorMaxLines: 2,
                            hintText: 'amount'.tr,
                            filled: true,
                            fillColor: ThemeController.to.getIsDarkMode
                                ? containerColorDarkTheme
                                : containerColorLightTheme,
                            // fillColor: Colors.white,
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
                        Container(
                          // height: 52.h,
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ThemeController.to.getIsDarkMode
                                  ? greyColor.withOpacity(.39)
                                  : strokeColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: ThemeController.to.getIsDarkMode
                                ? containerColorDarkTheme
                                : containerColorLightTheme,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              // value: 'gender',
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'required_field'.trParams({
                                    'name': 'currency'.tr,
                                  });
                                }
                                return null;
                              },
                              value: controller.getDepositCurrencySelect(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              decoration: InputDecoration(
                                errorText: controller
                                        .depositCurrencyError.value.isEmpty
                                    ? null
                                    : controller.depositCurrencyError.value,
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
                              hint: Text(
                                'currency'.tr,
                                style: TextStyle(
                                  fontFamily: Get.locale?.languageCode
                                              .compareTo('ar') ==
                                          0
                                      ? FontFamily.tajawal
                                      : FontFamily.inter,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ThemeController.to.getIsDarkMode
                                      ? unselectedBottomBarItemColorDarkTheme
                                      : textColor,
                                ),
                              ),
                              style: TextStyle(
                                //fontFamily: FontFamily.inter,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: ThemeController.to.getIsDarkMode
                                    ? unselectedBottomBarItemColorDarkTheme
                                    : textColor,
                              ),
                              isDense: true,
                              isExpanded: true,
                              items: [
                                ...controller
                                    .getCurrencies()
                                    .map(
                                      (Currency e) => DropdownMenuItem<String>(
                                        child: Text(
                                          Get.locale?.languageCode
                                                      .compareTo('ar') ==
                                                  0
                                              ? e.currencyId!
                                              : e.currencySign!,
                                          style: TextStyle(
                                            fontFamily: Get.locale?.languageCode
                                                        .compareTo('ar') ==
                                                    0
                                                ? FontFamily.tajawal
                                                : FontFamily.inter,
                                          ),
                                        ),
                                        value: Get.locale?.languageCode
                                                    .compareTo('ar') ==
                                                0
                                            ? e.currencyId!
                                            : e.currencySign!,
                                      ),
                                    )
                                    .toList(),
                              ],
                              // onChanged: controller.setCurrencySelect,
                              onChanged: null,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Theme(
                          data: ThemeController.to.getIsDarkMode
                              ? ThemeData.dark(useMaterial3: true).copyWith(
                                  colorScheme: ColorScheme.fromSeed(
                                      brightness: Brightness.dark,
                                      seedColor: Colors.blue))
                              : ThemeData.light().copyWith(
                                  colorScheme: ColorScheme.fromSeed(
                                      seedColor: Colors.blue)),
                          child: DateTimePicker(
                            controller: controller
                                .getDepositDateTextEditingController(),
                            // initialValue: 'date here',
                            // locale: Locale('ar'),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'required_field'.trParams({
                                  'name': 'date'.tr,
                                });
                              }
                              return null;
                            },
                            firstDate: DateTime(2000),
                            lastDate: DateTime(
                              tz.TZDateTime.now(kuwaitTimezoneLocation).year,
                              tz.TZDateTime.now(kuwaitTimezoneLocation).month,
                              tz.TZDateTime.now(kuwaitTimezoneLocation).day,
                            ),
                            // dateLabelText: 'date'.tr,
                            style: TextStyle(
                              color: ThemeController.to.getIsDarkMode
                                  ? unselectedBottomBarItemColorDarkTheme
                                  : unselectedBottomBarItemColorLightTheme,
                            ),
                            decoration: InputDecoration(
                              // labelText: 'date'.tr,
                              errorText:
                                  controller.depositDateError.value.isEmpty
                                      ? null
                                      : controller.depositDateError.value,

                              hintText: 'date'.tr,
                              hintStyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: ThemeController.to.getIsDarkMode
                                    ? unselectedBottomBarItemColorDarkTheme
                                    : null,
                              ),
                              suffixIcon: Padding(
                                padding: marginHorizontalBasedOnLanguage(11.w),
                                child: Iconify(
                                  Ic.twotone_date_range,
                                  size: 27,
                                  color: ThemeController.to.getIsDarkMode
                                      ? bottomBarItemColorDarkTheme
                                      : mainColor,
                                ),
                              ),
                              suffixIconConstraints: BoxConstraints(
                                  maxWidth: 27.w, maxHeight: 27.h),
                              fillColor: ThemeController.to.getIsDarkMode
                                  ? containerColorDarkTheme
                                  : containerColorLightTheme,
                              // fillColor: Colors.white,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
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
                            ),
                            onChanged: (val) => print(val),
                            onSaved: (val) => print(val),
                            // style: TextStyle(
                            //   fontSize: 13.sp,
                            //   fontWeight: FontWeight.w500,
                            //   color: Colors.black,
                            // ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        !controller.getIsErrorImage()
                            ? SizedBox.shrink()
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 15.h),
                                  Text(
                                    'attach_photo'.tr,
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(height: 20.h),
                        Container(
                          margin: EdgeInsets.only(left: 16.w, right: 15.w),
                          child: TextButton(
                            onPressed: controller.onDepositSendButtonClick,
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
                              'submit'.tr,
                              style: TextStyle(
                                //fontFamily: FontFamily.inter,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
          OperationListWidget(title: 'history_of_deposits'.tr, marginTop: 32.h),
        ],
      ),
    );
  }
}
