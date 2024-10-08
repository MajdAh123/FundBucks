import 'package:app/app/modules/home/controllers/home_controller.dart';
import 'package:app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageHeaderWidget extends GetView<HomeController> {
  final String title;
  final bool canBack;
  final bool hasNotificationIcon;
  final Widget? icon;
  final Widget? leading;
  final double paddingTop;
  final void Function()? onTapBack;
  const PageHeaderWidget({
    Key? key,
    required this.title,
    this.canBack = false,
    this.hasNotificationIcon = false,
    this.icon,
    this.leading,
    this.paddingTop = 35,
    this.onTapBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: paddingTop.h),
      margin:
          EdgeInsets.only(top: canBack ? 10.h : 15.h, left: 15.w, right: 17.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          canBack
              ? InkWell(
                  onTap: onTapBack == null
                      ? () => Navigator.of(context).pop()
                      : onTapBack,
                  child: Container(
                    width: 32.67.w,
                    height: 32.67.h,
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 4,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      color: Colors.transparent,
                    ),
                    child: SizedBox(
                      width: 13.79.w,
                      height: 14.83.h,
                      child: Iconify(
                        Get.locale?.languageCode.compareTo('ar') == 0
                            ? MaterialSymbols.arrow_forward_rounded
                            : MaterialSymbols.arrow_back_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                    // color: Colors.white,
                  ),
                )
              : leading != null
                  ? leading!
                  : SizedBox(width: 25.67.w),
          // canBack ? const SizedBox.shrink() : SizedBox(width: 25.67.w),
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  //fontFamily: FontFamily.inter,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: leading != null ? 30 : 0,
              ),
            ],
          ),
          hasNotificationIcon || icon == null
              ? NotificationIndicatorWidget(
                  hasNotification: controller.getIsThereNotification(),
                )
              : icon!,
        ],
      ),
    );
  }
}
