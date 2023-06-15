import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../controllers/verify_controller.dart';

class VerifyView extends GetView<VerifyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.to.getIsDarkMode
          ? backgroundColorDarkTheme
          : backgroundColorLightTheme,
      body: LogoCardWidget(
        cardHeight: 480.h,
        subTitle: controller.getIsPasswordReset()
            ? 'reset_code_send_to'.trParams({'email': controller.getEmailOtp()})
            : 'success_send_the_code_to'
                .trParams({'email': controller.getEmailOtp()}),
        content: Container(
            margin: EdgeInsets.only(right: 16.w, left: 16.w, top: 45.h),
            child: Obx(
              () => Form(
                key: controller.getFormKey(),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: OTPTextField(
                          controller: controller.getOtpTextFieldController(),
                          length: 6,
                          width: 200.w,
                          fieldWidth: 30.w,
                          style: TextStyle(
                            fontSize: 17.sp,
                          ),
                          textFieldAlignment: MainAxisAlignment.spaceBetween,
                          fieldStyle: FieldStyle.underline,
                          onChanged: controller.setOtp,
                          onCompleted: (pin) {
                            controller.setOtp(pin);
                            controller.onContinueButtonClick();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 45.h),
                    controller.getIsLoading()
                        ? Center(
                            child: SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: CircularProgressIndicator()))
                        : TextButton(
                            onPressed: controller.onContinueButtonClick,
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
                                  'verify'.tr,
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
                    controller.getIsLoading()
                        ? SizedBox.shrink()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Text(
                                  'code_have_not_reached'.tr,
                                  style: TextStyle(
                                    //fontFamily: FontFamily.inter,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              InkWell(
                                onTap: controller.onSendAgainClick,
                                child: Text(
                                  'send_again'.tr,
                                  style: TextStyle(
                                    //fontFamily: FontFamily.inter,
                                    color: ThemeController.to.getIsDarkMode
                                        ? bottomBarItemColorDarkTheme
                                        : mainColor,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 38.h),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
