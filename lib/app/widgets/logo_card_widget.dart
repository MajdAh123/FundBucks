import 'package:app/app/modules/theme_controller.dart';
import 'package:app/app/utils/utils.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LogoCardWidget extends StatelessWidget {
  final String? title;
  final String subTitle;
  final Widget content;
  final Widget? footer;
  final double cardHeight;
  const LogoCardWidget({
    Key? key,
    this.title,
    required this.subTitle,
    required this.content,
    this.footer,
    required this.cardHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: 305.h,
            color: ThemeController.to.getIsDarkMode
                ? mainColorDarkTheme
                : mainColor,
          ),
          if (title != null)
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 51.h),
                child: Text(
                  title!,
                  style: TextStyle(
                    fontSize: 18.sp,
                    //fontFamily: FontFamily.inter,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.fromLTRB(16.w, 190.h, 16.w, 5.h),
            // height: cardHeight,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  SizedBox(height: 70.h),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      subTitle,
                      style: TextStyle(
                        //fontFamily: FontFamily.inter,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  content
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 138.h),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 24,
                    offset: const Offset(0, 9),
                  ),
                ],
              ),
              child: ThemeController.to.getIsDarkMode
                  ? Assets.images.svg.logoDark.svg(
                      width: 119.w,
                      height: 119.h,
                      fit: BoxFit.contain,
                    )
                  : Assets.images.svg.logo.svg(
                      width: 119.w,
                      height: 119.h,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
          // if (footer != null) ...[
          //   Positioned(
          //     bottom: 0,
          //     child: Container(
          //       margin: EdgeInsets.only(bottom: 50),
          //       child: Text('data'),
          //     ),
          //   ),
          // ]
        ],
      ),
    );
  }
}
