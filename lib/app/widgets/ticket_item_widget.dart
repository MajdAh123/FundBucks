import 'package:app/app/modules/home/controllers/contact_controller.dart';
import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TicketItemWidget extends GetView<ContactController> {
  final bool hasNotification;
  final bool isClosed;
  final int id;
  final int status;
  final String ticketId;
  final String title;
  final String desc;
  final String avatar;
  final String message;
  final bool isAdmin;
  final String date;
  final String created_at;
  const TicketItemWidget({
    Key? key,
    this.hasNotification = false,
    this.isClosed = false,
    required this.id,
    required this.status,
    required this.ticketId,
    required this.title,
    required this.desc,
    required this.avatar,
    required this.message,
    required this.isAdmin,
    required this.date,
    required this.created_at,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        status == 0
            ? null
            : Get.toNamed('/ticket', arguments: [
                id, // 0
                'ticket'.trParams({'id': ticketId}), // 1
                title, // 2
                desc, // 3
                created_at, // 4
                isClosed, // 5
                status, // 6
              ]);
      },
      child: Container(
        width: 343.w,
        height: 85.h,
        constraints: BoxConstraints(maxHeight: 86.h),
        margin: EdgeInsets.only(bottom: 5.h, top: 0),
        padding:
            EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 11.h),
        decoration: BoxDecoration(
          color: ThemeController.to.getIsDarkMode
              ? containerColorDarkTheme
              : containerColorLightTheme,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(avatar),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 4,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    !isClosed
                        ? 'opened_ticket'.trParams({'id': ticketId, 'name': title})
                        : 'closed_ticket'.trParams({'id': ticketId, 'name': title}),
                    style: TextStyle(
                      //fontFamily: FontFamily.inter,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: ThemeController.to.getIsDarkMode
                          ? containerColorLightTheme
                          : chartTitleColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    isClosed
                        ? title
                        : Functions.getLatestMessage(isAdmin, message),
                    style: TextStyle(
                      //fontFamily: FontFamily.inter,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: ThemeController.to.getIsDarkMode
                          ? containerColorLightTheme
                          : chartTitleColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: true,
                  ),
                  SizedBox(height: 5.h),
                  status == 0
                      ? Text(
                          'wait_for_response'.tr,
                          style: TextStyle(
                            //fontFamily: FontFamily.inter,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: ThemeController.to.getIsDarkMode
                                ? unselectedBottomBarItemColorDarkTheme
                                : chartTitleColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                        )
                      : SizedBox.shrink(),
                  isClosed
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              created_at,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              // textAlign: TextAlign.end,
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),

            status != 1
                ? SizedBox.shrink()
                : Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      hasNotification
                          ? Expanded(
                              flex: 0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.orange.shade400,
                                    radius: 3.h,
                                  ),
                                  // Spacer(),
                                  // SizedBox(height: 5.h),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                //fontFamily: FontFamily.inter,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: ThemeController.to.getIsDarkMode
                                    ? containerColorLightTheme
                                    : chartTitleColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}
