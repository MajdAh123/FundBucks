import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/app/widgets/chatBubbleShape.dart';
// import 'package:app/app/widgets/chatBubbleShape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:chat_bubbles/chat_bubbles.dart';

import '../modules/lanuage_controller.dart';
import '../modules/ticket/controllers/ticket_controller.dart';

class ChatBubbleWidget extends StatelessWidget {
  final bool isMe;
  final bool hasImage;
  final String message;
  final String time;
  final String date;
  final String adminAvatar;
  final String? attachment;
  const ChatBubbleWidget({
    Key? key,
    required this.isMe,
    this.hasImage = false,
    required this.message,
    required this.time,
    required this.date,
    required this.adminAvatar,
    this.attachment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () {
          print('ahmeeed');
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
                                  BubbleNormalImage(
                                    onTap: () => Get.toNamed('/photo',
                                        arguments: [attachment]),
                                    seen: true,
                                    id: message,
                                    image: ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: 150.w, maxHeight: 200.w),
                                        child: Image.network(attachment!,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                          if (loadingProgress == null) {
                                            Get.find<TicketController>()
                                                .scrollToBottom();

                                            return child;
                                          } else {
                                            return Container(
                                              color: Colors.transparent,
                                              width: 150.w,
                                              height: 200.w,
                                              child: Center(
                                                child: SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            (loadingProgress
                                                                    .expectedTotalBytes ??
                                                                1)
                                                        : null,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        })),
                                    color: mainColor,
                                    tail: true,
                                    delivered: true,
                                  ),
                                  // Container(
                                  //   margin: EdgeInsets.only(top: 4.h),
                                  //   child: Wrap(
                                  //     alignment: WrapAlignment.end,
                                  //     children: [
                                  //       Container(
                                  //         constraints:
                                  //             BoxConstraints(maxWidth: 200.w),
                                  //         padding: EdgeInsets.symmetric(
                                  //             vertical: 8.h, horizontal: 8.w),
                                  //         decoration: BoxDecoration(
                                  //             border: Border.all(
                                  //                 width: 1,
                                  //                 color: Colors.grey[300]!),
                                  //             borderRadius:
                                  //                 const BorderRadius.only(
                                  //               topLeft: Radius.circular(5),
                                  //               bottomLeft: Radius.circular(5),
                                  //               bottomRight:
                                  //                   Radius.circular(12),
                                  //             )),
                                  //         child: Container(
                                  //           width: 80.w,
                                  //           height: 60.h,
                                  //           child:
                                  // ClipRRect(
                                  //               borderRadius:
                                  //                   const BorderRadius.all(
                                  //                       Radius.circular(8)),
                                  //               child:
                                  //                   Image.network(attachment!)),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(height: 3.h),
                                  BubbleTextWidget()
                                  // Container(
                                  //   constraints:
                                  //       BoxConstraints(maxWidth: 200.w),
                                  //   padding: EdgeInsets.symmetric(
                                  //       vertical: 8.h, horizontal: 8.w),
                                  //   decoration: BoxDecoration(
                                  //       border: Border.all(
                                  //           width: 1, color: Colors.grey[300]!),
                                  //       borderRadius: const BorderRadius.only(
                                  //         topLeft: Radius.circular(5),
                                  //         bottomLeft: Radius.circular(5),
                                  //         bottomRight: Radius.circular(12),
                                  //       ),
                                  //       color: Colors.grey[300]),
                                  //   child: Row(
                                  //     crossAxisAlignment:
                                  //         CrossAxisAlignment.end,
                                  //     mainAxisSize: MainAxisSize.min,
                                  //     children: [
                                  //       Flexible(
                                  //         child: Linkify(
                                  //           text: message,
                                  //           style: TextStyle(
                                  //             color: chatTextColor,
                                  //             fontSize: 14.sp,
                                  //             //fontFamily: FontFamily.inter,
                                  //             fontWeight: FontWeight.w500,
                                  //           ),
                                  //           onOpen: (link) async {
                                  //             if (await canLaunch(link.url)) {
                                  //               await launch(link.url);
                                  //             } else {
                                  //               throw 'Could not launch $link';
                                  //             }
                                  //           },
                                  //         ),
                                  //       ),
                                  //       Wrap(
                                  //         children: [
                                  //           SizedBox(width: 4.w),
                                  //           // Icon(Icons.done_all,
                                  //           //     color: read == true ? PRIMARY_COLOR : SOFT_GREY,
                                  //           //     size: 11),
                                  //           // SizedBox(width: 2),
                                  //           Text(time,
                                  //               style: TextStyle(
                                  //                 color: softGreyColor,
                                  //                 fontSize: 10.sp,
                                  //                 //fontFamily: FontFamily.inter,
                                  //                 fontWeight: FontWeight.w500,
                                  //               )),
                                  //         ],
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            )
                          : BubbleTextWidget()

                      // Container(
                      //     constraints:
                      //         BoxConstraints(maxWidth: Get.width * 0.7),
                      //     padding: EdgeInsets.symmetric(
                      //         vertical: 8.h, horizontal: 8.w),
                      //     decoration: BoxDecoration(
                      //         border: Border.all(
                      //             width: 1, color: Colors.grey[300]!),
                      //         borderRadius: const BorderRadius.only(
                      //           topLeft: Radius.circular(5),
                      //           bottomLeft: Radius.circular(5),
                      //           bottomRight: Radius.circular(12),
                      //         ),
                      //         color: Colors.grey[300]),
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.end,
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         Flexible(
                      //           child: Linkify(
                      //             text: message,
                      //             style: TextStyle(
                      //               color: chatTextColor,
                      //               fontSize: 14.sp,
                      //               //fontFamily: FontFamily.inter,
                      //               fontWeight: FontWeight.w500,
                      //             ),
                      //             onOpen: (link) async {
                      //               if (await canLaunch(link.url)) {
                      //                 await launch(link.url);
                      //               } else {
                      //                 throw 'Could not launch $link';
                      //               }
                      //             },
                      //           ),
                      //         ),
                      //         Wrap(
                      //           children: [
                      //             SizedBox(width: 4.w),
                      // Icon(Icons.done_all,
                      //     color: read == true ? PRIMARY_COLOR : SOFT_GREY,
                      //     size: 11),
                      // SizedBox(width: 2),
                      //             Text(time,
                      //                 style: TextStyle(
                      //                   color: softGreyColor,
                      //                   fontSize: 10.sp,
                      //                   //fontFamily: FontFamily.inter,
                      //                   fontWeight: FontWeight.w500,
                      //                 )),
                      //           ],
                      //         )
                      //       ],
                      //     ),
                      //   ),
                    ],
                  ),
                )

              // not me
              //
              //
              //
              //
              //
              //
              //
              //
              //
              //
              //
              //
              //
              //
              //
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
                                  Stack(
                                    children: [
                                      BubbleNormalImage(
                                        onTap: () => Get.toNamed('/photo',
                                            arguments: [attachment]),
                                        seen: true,
                                        // sent: true,
                                        isSender: false,
                                        id: message,
                                        image: ConstrainedBox(
                                            constraints: BoxConstraints(
                                                maxWidth: 150.w,
                                                maxHeight: 200.w),
                                            child: Image.network(
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  Get.find<TicketController>()
                                                      .scrollToBottom();
                                                  return child;
                                                } else {
                                                  return Container(
                                                    color: Colors.transparent,
                                                    width: 150.w,
                                                    height: 200.w,
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              (loadingProgress
                                                                      .expectedTotalBytes ??
                                                                  1)
                                                          : null,
                                                    ),
                                                  );
                                                }
                                              },
                                              attachment!,
                                            )),
                                        color:
                                            ThemeController.to.isDarkMode.isTrue
                                                ? containerColorDarkTheme
                                                : Colors.grey[300]!,
                                        tail: true,
                                        // delivered: true,
                                      ),
                                      Positioned(
                                        left: 15,
                                        top: 0,
                                        child: CircleAvatar(
                                          radius: 22,
                                          backgroundColor: ThemeController
                                                  .to.isDarkMode.isTrue
                                              ? mainColorDarkTheme
                                              : mainColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: CircleAvatar(
                                              radius: 23,
                                              backgroundImage:
                                                  NetworkImage(adminAvatar),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  BubbleTextWidget(
                                      isme: false, thereImage: true)
                                  // Container(
                                  //   margin:
                                  //       EdgeInsets.only(top: 4.h, left: 50.w),
                                  //   child: Wrap(
                                  //     alignment: WrapAlignment.start,
                                  //     children: [
                                  //       Container(
                                  //         constraints:
                                  //             BoxConstraints(maxWidth: 200.w),
                                  //         padding: EdgeInsets.symmetric(
                                  //             vertical: 8.h, horizontal: 8.w),
                                  //         decoration: BoxDecoration(
                                  //             border: Border.all(
                                  //                 width: 1,
                                  //                 color: Colors.grey[300]!),
                                  //             borderRadius:
                                  //                 const BorderRadius.only(
                                  //               topLeft: Radius.circular(5),
                                  //               bottomLeft: Radius.circular(5),
                                  //               bottomRight:
                                  //                   Radius.circular(12),
                                  //             )),
                                  //         child: Container(
                                  //           width: 80.w,
                                  //           height: 60.h,
                                  //           child: ClipRRect(
                                  //             borderRadius:
                                  //                 const BorderRadius.all(
                                  //                     Radius.circular(8)),
                                  //             child: Image.network(attachment!),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // SizedBox(height: 3.h),
                                  // Row(
                                  //   children: [
                                  //     CircleAvatar(
                                  //       backgroundImage:
                                  //           NetworkImage(adminAvatar),
                                  //     ),
                                  //     SizedBox(width: 3.w),
                                  //     Container(
                                  //       constraints:
                                  //           BoxConstraints(maxWidth: 200.w),
                                  //       padding: EdgeInsets.symmetric(
                                  //           vertical: 8.h, horizontal: 8.w),
                                  //       decoration: BoxDecoration(
                                  //           border: Border.all(
                                  //               width: 1,
                                  //               color: Colors.grey[300]!),
                                  //           borderRadius:
                                  //               const BorderRadius.only(
                                  //             topRight: Radius.circular(5),
                                  //             bottomLeft: Radius.circular(12),
                                  //             bottomRight: Radius.circular(5),
                                  //           )),
                                  //       child: Row(
                                  //         crossAxisAlignment:
                                  //             CrossAxisAlignment.end,
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: [
                                  //           Flexible(
                                  //             child: Linkify(
                                  //               text: message,
                                  //               style: TextStyle(
                                  //                 color: chatTextColor,
                                  //                 fontSize: 14.sp,
                                  //                 //fontFamily: FontFamily.inter,
                                  //                 fontWeight: FontWeight.w500,
                                  //               ),
                                  //               onOpen: (link) async {
                                  //                 if (await canLaunch(
                                  //                     link.url)) {
                                  //                   await launch(link.url);
                                  //                 } else {
                                  //                   throw 'Could not launch $link';
                                  //                 }
                                  //               },
                                  //             ),
                                  //           ),
                                  //           Wrap(
                                  //             children: [
                                  //               SizedBox(width: 2.w),
                                  //               Text(time,
                                  //                   style: TextStyle(
                                  //                     color: softGreyColor,
                                  //                     fontSize: 10.sp,
                                  //                     //fontFamily: FontFamily.inter,
                                  //                     fontWeight:
                                  //                         FontWeight.w500,
                                  //                   )),
                                  //             ],
                                  //           )
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            )
                          : BubbleTextWidget(isme: false)
                      // Row(
                      //     children: [
                      //       CircleAvatar(
                      //         backgroundImage: NetworkImage(adminAvatar),
                      //       ),
                      //       SizedBox(width: 3.w),

                      //       // Container(
                      //       //   constraints:
                      //       //       BoxConstraints(maxWidth: Get.width * 0.7),
                      //       //   padding: EdgeInsets.symmetric(
                      //       //       vertical: 8.h, horizontal: 8.w),
                      //       //   decoration: BoxDecoration(
                      //       //       border: Border.all(
                      //       //           width: 1, color: Colors.grey[300]!),
                      //       //       borderRadius: const BorderRadius.only(
                      //       //         topRight: Radius.circular(5),
                      //       //         bottomLeft: Radius.circular(12),
                      //       //         bottomRight: Radius.circular(5),
                      //       //       )),
                      //       //   child: Row(
                      //       //     crossAxisAlignment: CrossAxisAlignment.end,
                      //       //     mainAxisSize: MainAxisSize.min,
                      //       //     children: [
                      //       //       Flexible(
                      //       //         child: Linkify(
                      //       //           text: message,
                      //       //           style: TextStyle(
                      //       //             color:
                      //       //  ThemeController
                      //       //                     .to.getIsDarkMode
                      //       //                 ? unselectedBottomBarItemColorDarkTheme
                      //       //                 : chatTextColor,
                      //       //             fontSize: 14.sp,
                      //       //             //fontFamily: FontFamily.inter,
                      //       //             fontWeight: FontWeight.w500,
                      //       //           ),
                      //       //           onOpen: (link) async {
                      //       //             if (await canLaunch(link.url)) {
                      //       //               await launch(link.url);
                      //       //             } else {
                      //       //               throw 'Could not launch $link';
                      //       //             }
                      //       //           },
                      //       //         ),
                      //       //       ),
                      //       //       Wrap(
                      //       //         children: [
                      //       //           SizedBox(width: 2.w),
                      //       //           Text(time,
                      //       //               style: TextStyle(
                      //       //                 color: softGreyColor,
                      //       //                 fontSize: 10.sp,
                      //       //                 //fontFamily: FontFamily.inter,
                      //       //                 fontWeight: FontWeight.w500,
                      //       //               )),
                      //       //         ],
                      //       //       )
                      //       //     ],
                      //       //   ),
                      //       // ),
                      //     ],
                      //   ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  GestureDetector BubbleTextWidget(
      {bool isme = true, bool thereImage = false}) {
    return GestureDetector(
      onTap: () async {
        print("object");
        if (_extractLink(message) != null) {
          if (await canLaunch(_extractLink(message)!)) {
            await launch(_extractLink(message)!);
          } else {
            throw 'Could not launch ${_extractLink(message)}';
          }
        }
      },
      child: Stack(
        children: [
          BubbleSpecialThree(
              constraints: BoxConstraints(
                  minWidth: Get.width * 0.2, maxWidth: Get.width * 0.7),
              text: isme
                  ? '$message \n'
                  : thereImage
                      ? "$message\n"
                      : "\n         $message\n",
              color: isme
                  ? mainColor
                  : ThemeController.to.isDarkMode.isTrue
                      ? containerColorDarkTheme
                      : Colors.grey[300]!,
              tail: true,
              seen: !isme,
              delivered: true,
              isSender: isme,
              textStyle: TextStyle(
                color: containsLink(message)
                    ? isme
                        ? Colors.white
                        : Colors.blue
                    : isme
                        ? Colors.white
                        : ThemeController.to.getIsDarkMode
                            ? unselectedBottomBarItemColorDarkTheme
                            : chatTextColor,
                fontSize: 14.sp,
                //fontFamily: FontFamily.inter,
                fontWeight:
                    containsLink(message) ? FontWeight.bold : FontWeight.w500,
              )),
          if (!isme && !thereImage)
            Positioned(
              left: 15,
              top: 0,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: ThemeController.to.isDarkMode.isTrue
                    ? mainColorDarkTheme
                    : mainColor,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: CircleAvatar(
                    radius: 23,
                    backgroundImage: NetworkImage(adminAvatar),
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 15,
            right: isme ? 45 : null,
            left: isme ? null : 45,
            child: Text(time,
                style: TextStyle(
                  color: isme
                      ? Colors.white70
                      : ThemeController.to.getIsDarkMode
                          ? Colors.grey
                          : Colors.black54,
                  fontSize: 10.sp,
                  //fontFamily: FontFamily.inter,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Positioned(
            bottom: 6,
            right: isme ? 45 : null,
            left: isme ? null : 40,
            child: Text(date,
                style: TextStyle(
                  color: isme
                      ? Colors.white70
                      : ThemeController.to.getIsDarkMode
                          ? Colors.grey
                          : Colors.black54,
                  fontSize: 8.sp,
                  //fontFamily: FontFamily.inter,
                  fontWeight: FontWeight.w500,
                )),
          )
        ],
      ),
    );
  }

  String? _extractLink(String text) {
    final urlPattern = r'(https?:\/\/[^\s]+)';
    final regExp = RegExp(urlPattern, caseSensitive: false);
    final match = regExp.firstMatch(text);
    if (match != null) {
      return match.group(0); // Returns the first matched URL
    }
    return null;
  }

  bool containsLink(String text) {
    final urlPattern = r'(https?:\/\/[^\s]+)';
    final regExp = RegExp(urlPattern, caseSensitive: false);
    return regExp.hasMatch(text);
  }
}
