import 'package:app/app/modules/home/controllers/contact_controller.dart';
import 'package:app/app/modules/home/views/account_page_view.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:timezone/standalone.dart' as tz;

class ContactPageView extends GetView<ContactController> {
  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: ClassicHeader(
        dragText: 'pull_to_refresh'.tr,
        armedText: 'release_ready'.tr,
        messageText: 'last_updated_at'.tr,
        readyText: 'refreshing'.tr,
      ),
      footer: MyFooter(
        triggerOffset: 1,
        clamping: false,
      ),
      onRefresh: () {
        controller.clearAllForms();
        controller.getAllTickets();
      },
      onLoad: () async {},
      child: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: 110.h,
              color: mainColor,
            ),
            PageHeaderWidget(title: 'contact'.tr),
            const DisplayTicketsTypeButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class DisplayTicketsTypeButtonWidget extends GetView<ContactController> {
  const DisplayTicketsTypeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Column(
          children: [
            Container(
              width: 325.w,
              height: 56.h,
              margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 90.h),
              padding: EdgeInsets.only(left: 3.w, right: 3.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.setIndex(0);
                        // controller.operationController.reset();
                        // controller.operationController.forward();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 102.3.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: controller.getIndex() == 0
                              ? controller.getColor()
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'new_case'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              //fontFamily: FontFamily.inter,
                              fontWeight: FontWeight.w500,
                              color: controller.getIndex() == 0
                                  ? Colors.white
                                  : unselectedBottomBarItemColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.setIndex(1);
                        // controller.operationController.reset();
                        // controller.operationController.forward();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 102.3.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: controller.getIndex() == 1
                              ? controller.getColor()
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'open_cases'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              //fontFamily: FontFamily.inter,
                              fontWeight: FontWeight.w500,
                              color: controller.getIndex() == 1
                                  ? Colors.white
                                  : unselectedBottomBarItemColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.setIndex(2);
                        // controller.operationController.reset();
                        // controller.operationController.forward();
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: 102.3.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: controller.getIndex() == 2
                              ? controller.getColor()
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'solved_cases'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              //fontFamily: FontFamily.inter,
                              fontWeight: FontWeight.w500,
                              color: controller.getIndex() == 2
                                  ? Colors.white
                                  : unselectedBottomBarItemColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
              child: Column(
                children: [
                  if (controller.getIndex() == 0) ...[
                    controller.getIsLoading()
                        ? Center(
                            child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : const NewCaseFormWidget(),
                  ] else if (controller.getIndex() == 1) ...[
                    controller.getIsLoading()
                        ? Center(
                            child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : controller.openTicketsList.isEmpty
                            ? Center(
                                child: Text(
                                  'no_open_tickets'.tr,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(top: 0.h),
                                child: ListView(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: 0),
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    ...controller.openTicketsList
                                        .map(
                                          (e) => TicketItemWidget(
                                              id: e.id ?? 0,
                                              hasNotification: controller
                                                  .checkIfTicketNotifications(
                                                      e.id),
                                              title: e.name ?? '',
                                              desc: e.subject ?? '',
                                              ticketId: e.ticket ?? '',
                                              status: e.status!,
                                              isClosed: e.status == 2,
                                              created_at:
                                                  intl.DateFormat('yyyy-MM-dd h:m a')
                                                      .format(e.createdAt ??
                                                          tz.TZDateTime.now(
                                                              kuwaitTimezoneLocation))
                                                      .toString(),
                                              avatar: Functions.getUserAvatar(
                                                controller.homeController
                                                        .getUser()!
                                                        .avatar ??
                                                    '',
                                              ),
                                              isAdmin: e.latestSupportMessage
                                                      ?.isAdmin ==
                                                  1,
                                              message: e.latestSupportMessage
                                                      ?.message ??
                                                  '',
                                              date: intl.DateFormat('h:m a')
                                                  .format(e.latestSupportMessage
                                                          ?.createdAt ??
                                                      tz.TZDateTime.now(kuwaitTimezoneLocation))
                                                  .toString()),
                                        )
                                        .toList(),
                                  ],
                                ),
                              ),
                  ] else ...[
                    controller.getIsLoading()
                        ? Center(
                            child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : controller.closedTicketsList.isEmpty
                            ? Center(
                                child: Text(
                                  'no_closed_tickets'.tr,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            : Center(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(top: 0),
                                  children: controller.closedTicketsList
                                      .map(
                                        (e) => TicketItemWidget(
                                            id: e.id ?? 0,
                                            hasNotification: controller
                                                .checkIfTicketNotifications(
                                                    e.id),
                                            title: e.name ?? '',
                                            desc: e.subject ?? '',
                                            ticketId: e.ticket ?? '',
                                            isClosed: e.status == 2,
                                            status: e.status!,
                                            created_at: intl.DateFormat('yyyy-MM-dd h:m a')
                                                .format(e.createdAt ??
                                                    tz.TZDateTime.now(
                                                        kuwaitTimezoneLocation))
                                                .toString(),
                                            avatar: Functions.getUserAvatar(
                                              controller.homeController
                                                      .getUser()!
                                                      .avatar ??
                                                  '',
                                            ),
                                            isAdmin: e.latestSupportMessage?.isAdmin ==
                                                1,
                                            message:
                                                e.latestSupportMessage?.message ??
                                                    '',
                                            date: intl.DateFormat('h:m a')
                                                .format(e.latestSupportMessage
                                                        ?.createdAt ??
                                                    tz.TZDateTime.now(
                                                        kuwaitTimezoneLocation))
                                                .toString()),
                                      )
                                      .toList(),
                                ),
                              ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
