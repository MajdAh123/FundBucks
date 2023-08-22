import 'package:app/app/modules/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListViewWidget extends StatelessWidget {
  final double _containerHeight = 20.h;
  final double _spaceHeight = 10.h;
  final Color _shimmerColor = Colors.grey[200]!;
  final Color _shimmerColorDark = Colors.grey[800]!;
  ShimmerListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: 8,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10.w, 20.h, 20.w, 0.h),
              child: Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: ThemeController.to.getIsDarkMode
                    ? _shimmerColorDark
                    : _shimmerColor,
                period: const Duration(milliseconds: 1000),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 12.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: ThemeController.to.getIsDarkMode
                            ? _shimmerColorDark
                            : _shimmerColor,
                      ),
                      height: 110.h,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          color: Colors.white,
                        ),
                        child: Container(width: 80.w),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            padding: EdgeInsets.only(left: 12.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: ThemeController.to.getIsDarkMode
                                  ? _shimmerColorDark
                                  : _shimmerColor,
                            ),
                            height: _containerHeight,
                            child: Container(
                                decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                              color: Colors.white,
                            )),
                          ),
                          SizedBox(
                            height: _spaceHeight,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: ThemeController.to.getIsDarkMode
                                  ? _shimmerColorDark
                                  : _shimmerColor,
                            ),
                            height: _containerHeight,
                            child: Container(
                                decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                              color: Colors.white,
                            )),
                          ),
                          SizedBox(
                            height: _spaceHeight,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: ThemeController.to.getIsDarkMode
                                  ? _shimmerColorDark
                                  : _shimmerColor,
                            ),
                            height: _containerHeight,
                            width: 100.w,
                            child: Container(
                                decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0)),
                              color: Colors.white,
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.h),
              color: ThemeController.to.getIsDarkMode
                  ? _shimmerColorDark
                  : _shimmerColor,
              height: 1.h,
            ),
          ],
        );
      },
    );
  }
}
