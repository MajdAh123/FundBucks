import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class ColumnCardWidget extends StatefulWidget {
  final String title;
  final String value;
  final Color? color;
  final Widget? beforeValue;
  final Widget? afterValue;
  final double? maxWidth;
  final bool isCenter;
  final bool isRight;
  final double? textValueSize;
  const ColumnCardWidget({
    super.key,
    required this.title,
    required this.value,
    this.color = const Color(0xFF0579B5),
    this.beforeValue,
    this.afterValue,
    this.maxWidth,
    this.isCenter = false,
    this.isRight = false,
    this.textValueSize = 15,
  });

  @override
  State<ColumnCardWidget> createState() => _ColumnCardWidgetState();
}

class _ColumnCardWidgetState extends State<ColumnCardWidget> {
  var tooltipController = JustTheController();

  @override
  void initState() {
    super.initState();
    tooltipController = JustTheController();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: widget.isCenter ? 314.w : (314.w / 2.5.w),
        // constraints: BoxConstraints(maxWidth: widget.maxWidth ?? 85.w),
        child: Column(
          crossAxisAlignment: widget.isCenter
              ? CrossAxisAlignment.center
              : Get.locale?.languageCode.compareTo('ar') == 0
                  ? widget.isRight
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end
                  : !widget.isRight
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 12.sp,
                //fontFamily: FontFamily.inter,
                fontWeight: FontWeight.w400,
                color: ThemeController.to.getIsDarkMode
                    ? unselectedBottomBarItemColorDarkTheme
                    : unselectedBottomBarItemColorLightTheme,
              ),
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: widget.isCenter
                  ? MainAxisAlignment.center
                  : Get.locale?.languageCode.compareTo('ar') == 0
                      ? widget.isRight
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end
                      : !widget.isRight
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
              children: [
                if (widget.beforeValue != null) ...[
                  // const Spacer(),

                  widget.beforeValue!,
                  SizedBox(width: 3.w),
                  // if (!widget.isRight) ...[
                  // const Spacer(),
                  // ]
                ],
                JustTheTooltip(
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.value,
                      style: TextStyle(
                        fontSize: 13.sp,
                        //fontFamily: FontFamily.inter,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  backgroundColor: widget.color ?? mainColor,
                  controller: tooltipController,
                  child: InkWell(
                    onTap: () {
                      tooltipController.showTooltip();
                    },
                    child: Text(
                      widget.value,
                      style: TextStyle(
                        fontSize: widget.textValueSize?.sp,
                        //fontFamily: FontFamily.inter,
                        fontWeight: FontWeight.w700,
                        color: widget.color,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      // textDirection:
                      //     widget.isRight ? TextDirection.ltr : TextDirection.rtl,
                    ),
                  ),
                ),
                if (widget.afterValue != null) ...[
                  // context.sizedBoxHorizontal(3.w),
                  SizedBox(width: 3.w),
                  widget.afterValue!,
                  // const Spacer(),
                ],
                if (!widget.isCenter && !widget.isRight) ...[
                  sizedBoxHorizontal(22.w),
                  // SizedBox(width: 22.w),
                  Get.locale?.languageCode.compareTo('ar') == 0
                      ? const SizedBox.shrink()
                      : const Directionality(
                          textDirection: TextDirection.ltr,
                          child: Spacer(),
                        ),
                  // context.sizedBoxHorizontal(22.w),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
