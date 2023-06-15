import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:intl/intl.dart' as intl;
import 'package:timezone/standalone.dart' as tz;

import '../controllers/ticket_controller.dart';

class TicketView extends GetView<TicketController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // persistentFooterButtons: [],
      backgroundColor: ThemeController.to.getIsDarkMode
          ? backgroundColorDarkTheme
          : backgroundColorLightTheme,
      body: Obx(
        () => Column(
          children: [
            Container(
              height: 90.h,
              color: ThemeController.to.getIsDarkMode
                  ? mainColorDarkTheme
                  : mainColor,
              child: PageHeaderWidget(
                title: controller.getTicketUniqueId(),
                canBack: true,
                hasNotificationIcon: false,
                icon: PopupMenuButton(
                  onSelected: (value) {
                    if (controller.simpleChoice.indexOf(value) == 0)
                      controller.showDetailsDialog();
                    else
                      controller.closeTicket();
                  },
                  itemBuilder: (BuildContext context) {
                    return controller.simpleChoice.map((String choice) {
                      return PopupMenuItem(
                        value: choice,
                        // onTap: () {
                        //   if (controller.simpleChoice.indexOf(choice) == 0) {
                        //     controller.showDetailsDialog();
                        //   }
                        // },
                        child: Text(
                          choice,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList();
                  },
                  color: ThemeController.to.getIsDarkMode
                      ? containerColorDarkTheme
                      : containerColorLightTheme,
                  icon: GestureDetector(
                    // onTap: () {
                    //   controller.showDetailsDialog();
                    // },
                    child: const Iconify(
                      Mdi.dots_vertical,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                controller: controller.scrollController,
                padding: EdgeInsets.zero,
                children: controller.getIsLoading()
                    ? [
                        SizedBox(height: 50.h),
                        Center(
                          child: SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ]
                    : controller.supportMessages
                        .map(
                          (element) => ChatBubbleWidget(
                            isMe: element.isAdmin == 0,
                            message: element.message ?? '',
                            hasImage: element.attachment != null,
                            attachment: element.attachment,
                            time: intl.DateFormat('h:m a')
                                .format(element.createdAt ??
                                    tz.TZDateTime.now(kuwaitTimezoneLocation))
                                .toString(),
                            adminAvatar: element.adminAvatar ?? '',
                          ),
                        )
                        .toList(),
              ),
            ),
            SizedBox(height: 10.h),
            !controller.getIsTicketClosed()
                ? const BottomBarTicketWidget()
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
