import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatBubbleWidget extends StatelessWidget {
  final bool isMe;
  final bool hasImage;
  final String message;
  final String time;
  final String adminAvatar;
  final String? attachment;
  const ChatBubbleWidget({
    Key? key,
    required this.isMe,
    this.hasImage = false,
    required this.message,
    required this.time,
    required this.adminAvatar,
    this.attachment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () {
          print('object');
        },
        onLongPress: () {
          print('test');
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: isMe
              ? Container(
                  margin: EdgeInsets.only(top: 4.h),
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    children: [
                      hasImage
                          ? GestureDetector(
                              onTap: () => Get.toNamed('/photo',
                                  arguments: [attachment]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 4.h),
                                    child: Wrap(
                                      alignment: WrapAlignment.end,
                                      children: [
                                        Container(
                                          constraints:
                                              BoxConstraints(maxWidth: 200.w),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.h, horizontal: 8.w),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey[300]!),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                bottomLeft: Radius.circular(5),
                                                bottomRight:
                                                    Radius.circular(12),
                                              )),
                                          child: Container(
                                            width: 80.w,
                                            height: 60.h,
                                            child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(8)),
                                                child:
                                                    Image.network(attachment!)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  Container(
                                    constraints:
                                        BoxConstraints(maxWidth: 200.w),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.h, horizontal: 8.w),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.grey[300]!),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: Radius.circular(12),
                                        ),
                                        color: Colors.grey[300]),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(message,
                                              style: TextStyle(
                                                color: chatTextColor,
                                                fontSize: 14.sp,
                                                //fontFamily: FontFamily.inter,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ),
                                        Wrap(
                                          children: [
                                            SizedBox(width: 4.w),
                                            // Icon(Icons.done_all,
                                            //     color: read == true ? PRIMARY_COLOR : SOFT_GREY,
                                            //     size: 11),
                                            // SizedBox(width: 2),
                                            Text(time,
                                                style: TextStyle(
                                                  color: softGreyColor,
                                                  fontSize: 10.sp,
                                                  //fontFamily: FontFamily.inter,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              constraints: BoxConstraints(maxWidth: 200.w),
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.h, horizontal: 8.w),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.grey[300]!),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  color: Colors.grey[300]),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(message,
                                        style: TextStyle(
                                          color: chatTextColor,
                                          fontSize: 14.sp,
                                          //fontFamily: FontFamily.inter,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                  Wrap(
                                    children: [
                                      SizedBox(width: 4.w),
                                      // Icon(Icons.done_all,
                                      //     color: read == true ? PRIMARY_COLOR : SOFT_GREY,
                                      //     size: 11),
                                      // SizedBox(width: 2),
                                      Text(time,
                                          style: TextStyle(
                                            color: softGreyColor,
                                            fontSize: 10.sp,
                                            //fontFamily: FontFamily.inter,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: 4.h),
                  child: Wrap(
                    children: [
                      hasImage
                          ? GestureDetector(
                              onTap: () => Get.toNamed('/photo',
                                  arguments: [attachment]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 4.h, left: 50.w),
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      children: [
                                        Container(
                                          constraints:
                                              BoxConstraints(maxWidth: 200.w),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.h, horizontal: 8.w),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey[300]!),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                bottomLeft: Radius.circular(5),
                                                bottomRight:
                                                    Radius.circular(12),
                                              )),
                                          child: Container(
                                            width: 80.w,
                                            height: 60.h,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                              child: Image.network(attachment!),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(adminAvatar),
                                      ),
                                      SizedBox(width: 3.w),
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 200.w),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.h, horizontal: 8.w),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.grey[300]!),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(5),
                                              bottomLeft: Radius.circular(12),
                                              bottomRight: Radius.circular(5),
                                            )),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Text(message,
                                                  style: TextStyle(
                                                    color: chatTextColor,
                                                    fontSize: 14.sp,
                                                    //fontFamily: FontFamily.inter,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            ),
                                            Wrap(
                                              children: [
                                                SizedBox(width: 2.w),
                                                Text(time,
                                                    style: TextStyle(
                                                      color: softGreyColor,
                                                      fontSize: 10.sp,
                                                      //fontFamily: FontFamily.inter,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(adminAvatar),
                                ),
                                SizedBox(width: 3.w),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 200.w),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.h, horizontal: 8.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey[300]!),
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(5),
                                      )),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(message,
                                            style: TextStyle(
                                              color: ThemeController
                                                      .to.getIsDarkMode
                                                  ? unselectedBottomBarItemColorDarkTheme
                                                  : chatTextColor,
                                              fontSize: 14.sp,
                                              //fontFamily: FontFamily.inter,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ),
                                      Wrap(
                                        children: [
                                          SizedBox(width: 2.w),
                                          Text(time,
                                              style: TextStyle(
                                                color: softGreyColor,
                                                fontSize: 10.sp,
                                                //fontFamily: FontFamily.inter,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
