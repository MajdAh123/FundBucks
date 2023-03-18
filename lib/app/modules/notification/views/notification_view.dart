import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Obx(
        () => Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Column(
            children: [
              Container(
                height: 70.h,
                color: mainColor,
                child: PageHeaderWidget(
                  title: 'notifications'.tr,
                  canBack: true,
                  hasNotificationIcon: false,
                  icon: const SizedBox(),
                ),
              ),
              Expanded(
                  child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                child: controller.loading.value
                    ? ShimmerListViewWidget()
                    : controller.getNotifications().isEmpty
                        ? Center(
                            child: Text(
                              'no_new_notifications'.tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 0),
                            children: [
                              controller.getNotifications().length > 0
                                  ? InkWell(
                                      onTap: controller.readAllNotifications,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'mark_all_as_read'.tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: mainColor,
                                              //fontFamily: FontFamily.inter,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(height: 10.h),
                              ...controller.getNotifications().map(
                                    (e) => NotificationItemWidget(
                                      title: e.title ?? '',
                                      time: e.createdAt != null
                                          ? DateFormat('yyyy-MM-dd kk:mm a')
                                              .format(e.createdAt!)
                                          : '',
                                      description: e.description ?? '',
                                      isRead: e.read == 1,
                                      onTap: () => e.read == 1
                                          ? null
                                          : controller.readNotification(e.id),
                                      onDeleteTap: () =>
                                          controller.deleteNotification(e.id),
                                    ),
                                  ),
                            ],
                          ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
