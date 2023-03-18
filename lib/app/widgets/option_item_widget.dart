import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionItemWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  final VoidCallback onTap;
  final bool isLastItem;
  const OptionItemWidget({
    Key? key,
    required this.title,
    this.textColor = const Color(0xFF515151),
    required this.onTap,
    this.isLastItem = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: isLastItem ? 4.h : 12.h),
        padding: EdgeInsets.fromLTRB(17.w, 18.h, 16.w, 18.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: strokeColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: textColor,
                //fontFamily: FontFamily.inter,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(Icons.chevron_right, size: 20, color: softGreyColor),
          ],
        ),
      ),
    );
  }
}
