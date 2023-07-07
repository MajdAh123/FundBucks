import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class StockColumnWidget extends StatefulWidget {
  final String title;
  final String icon;
  final double close;
  final double change;
  final double change_p;
  final double iconSize;
  final bool isDowJones;

  const StockColumnWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.close,
    required this.change,
    required this.change_p,
    this.iconSize = 28,
    this.isDowJones = false,
  }) : super(key: key);

  @override
  State<StockColumnWidget> createState() => _StockColumnWidgetState();
}

class _StockColumnWidgetState extends State<StockColumnWidget> {
  var tooltipController = JustTheController();

  @override
  void initState() {
    super.initState();
    tooltipController = JustTheController();
  }

  Color getAmountColor(double value) {
    if (value == 0) {
      return unselectedBottomBarItemColorLightTheme;
    }

    return value > 0 ? successColor : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => tooltipController.showTooltip(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            JustTheTooltip(
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: (Get.locale?.languageCode.compareTo('ar') == 0)
                        ? 13.sp
                        : 12.sp,
                    //fontFamily: FontFamily.inter,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              backgroundColor: ThemeController.to.getIsDarkMode
                  ? bottomBarItemColorDarkTheme
                  : mainColor,
              controller: tooltipController,
              child: widget.isDowJones
                  ? Assets.images.svg.dowJonesIcon.svg(
                      width: 28.w,
                      height: 28.h,
                      color: ThemeController.to.getIsDarkMode
                          ? bottomBarItemColorDarkTheme
                          : mainColor,
                    )
                  : Iconify(
                      widget.icon,
                      size: widget.iconSize,
                      color: ThemeController.to.getIsDarkMode
                          ? bottomBarItemColorDarkTheme
                          : mainColor,
                    ),
            ),
            SizedBox(height: 5.h),
            Text(
              '\$${(widget.close < 0 ? widget.close * -1 : widget.close).toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: (Get.locale?.languageCode.compareTo('ar') == 0)
                    ? 14.sp
                    : 13.sp,
                fontWeight: FontWeight.w600,
                color: widget.close == 0
                    ? unselectedBottomBarItemColorLightTheme
                    : !(widget.change < 0 || widget.change_p < 0)
                        ? successColor
                        : Colors.red,
                //fontFamily: FontFamily.inter,
              ),
            ),
            SizedBox(height: 3.h),
            Wrap(
              children: [
                Text(
                  '\$${(widget.change < 0 ? widget.change * -1 : widget.change * 1).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: (Get.locale?.languageCode.compareTo('ar') == 0)
                        ? 13.sp
                        : 12.sp,
                    fontWeight: FontWeight.w500,
                    color: getAmountColor(widget.change),
                    //fontFamily: FontFamily.inter,
                  ),
                ),
                SizedBox(width: 2.w),
                Text(
                  '(%${(widget.change_p < 0 ? widget.change_p * -1 : widget.change_p * 1).toStringAsFixed(2)})',
                  style: TextStyle(
                    fontSize: (Get.locale?.languageCode.compareTo('ar') == 0)
                        ? 12.sp
                        : 11.sp,
                    fontWeight: FontWeight.w600,
                    color: getAmountColor(widget.change_p),
                    //fontFamily: FontFamily.inter,
                  ),
                ),
                // SizedBox(width: 1.w),
                // Iconify(
                //   widget.value >= 0 ? Bi.arrow_up_short : Bi.arrow_down_short,
                //   size: 16,
                //   color: widget.value >= 0 ? successColor : Colors.red,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
