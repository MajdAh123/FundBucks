import 'dart:developer';

import 'package:app/app/modules/support_card/controllers/support_card_controller.dart';
import 'package:app/app/modules/support_card/providers/support_card_provider.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SupportCardWidget extends GetView<SupportCardController> {
  const SupportCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupportCardController>(
      init: SupportCardController(
          supportCardProvider: Get.find<SupportCardProvider>()),
      builder: (controller) => Container(
        child: ExpansionPanelList(
          elevation: 4,
          expansionCallback: (int index, bool isExpanded) {
            log("the update is: ${isExpanded}");
            controller.supportCardItemList[index].isExpanded =
                !controller.supportCardItemList[index].isExpanded;
            controller.update();
          },
          expandedHeaderPadding: EdgeInsets.symmetric(vertical: 1.h),
          children: controller.supportCardItemList
              .map<ExpansionPanel>(
                (e) => ExpansionPanel(
                  isExpanded: e.isExpanded,
                  canTapOnHeader: true,
                  backgroundColor: ThemeController.to.getIsDarkMode
                      ? containerColorDarkTheme
                      : containerColorLightTheme,
                  headerBuilder: (context, isExpanded) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Get.locale?.languageCode.compareTo('ar') == 0
                              ? e.title
                              : e.enTitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  body: Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Text(
                      Get.locale?.languageCode.compareTo('ar') == 0
                          ? e.body
                          : e.enBody,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
