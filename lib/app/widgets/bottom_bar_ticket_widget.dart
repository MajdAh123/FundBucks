import 'dart:io';

import 'package:app/app/modules/ticket/controllers/ticket_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent_mdl2.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class BottomBarTicketWidget extends GetView<TicketController> {
  const BottomBarTicketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: controller.getFormKey(),
        autovalidateMode: AutovalidateMode.disabled,
        child: Container(
          // height: 80.h,
          padding: EdgeInsets.fromLTRB(5.w, 12.h, 5.w, 12.h),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(11), topLeft: Radius.circular(11)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              if (!controller.getFilePath().isEmpty) ...[
                Stack(
                  children: [
                    Image.file(
                      controller.getFile(),
                      width: 80.w,
                      height: 80.h,
                    ),
                    controller.getFilePath().isEmpty
                        ? SizedBox.shrink()
                        : Positioned(
                            left: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: controller.clearFile,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: mainColor,
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
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  controller.getFilePath().isEmpty
                      ? IconButton(
                          onPressed: controller.showImageSelection,
                          icon: Iconify(
                            Mdi.file_image_plus_outline,
                            color: mainColor,
                          ),
                        )
                      : SizedBox.shrink(),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 5.w),
                      child: TextFormField(
                        controller: controller.messageTextFieldController.value,
                        minLines: 1,
                        maxLines: 2,

                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'required_field'.trParams({
                              'name': '',
                            });
                          }
                          return null;
                        },
                        style: TextStyle(
                          letterSpacing: 0.1,
                          // color: theme.colorScheme.onBackground,
                          // fontWeight: 500,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          errorMaxLines: 2,
                          hintText: 'type_here'.tr,
                          hintStyle: TextStyle(
                            letterSpacing: 0.1,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                              borderSide: BorderSide(
                                  color: unselectedBottomBarItemColor,
                                  width: 1)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                            borderSide: BorderSide(
                                color: unselectedBottomBarItemColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.r),
                            ),
                            borderSide: BorderSide(
                                color: unselectedBottomBarItemColor, width: 1),
                          ),
                          isDense: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        // textInputAction: TextInputAction.send,
                        onFieldSubmitted: (message) {},
                        // controller: _chatTextController,
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  // Spacer(),
                  controller.getIsSendingMessage()
                      ? Center(
                          child: SizedBox(
                            width: 20.w,
                            height: 20.h,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: mainColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 1.w),
                            child: IconButton(
                              onPressed: controller.onSendMessageButtonClick,
                              icon: Transform.rotate(
                                angle:
                                    Get.locale?.languageCode.compareTo('ar') ==
                                            0
                                        ? 600.0
                                        : 0,
                                child: const Iconify(
                                  FluentMdl2.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
