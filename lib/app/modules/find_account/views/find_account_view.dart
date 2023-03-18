import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/find_account_controller.dart';

class FindAccountView extends GetView<FindAccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: LogoCardWidget(
        cardHeight: 480.h,
        subTitle: 'find_account'.tr,
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
                    controller:
                        controller.usernameOrEmailTextEditingController.value,
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
                      errorMaxLines: 2,
                      hintText: 'username_or_email'.tr,
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
                            backgroundColor: mainColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'continue_text'.tr,
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
