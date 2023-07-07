import 'package:app/app/data/models/models.dart';
import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AssetsWidgetPainter extends CustomPainter {
  final double? lineWidth;
  final List<AssetModel> list;
  final String currency;

  AssetsWidgetPainter({
    required this.list,
    required this.currency,
  }) : lineWidth = 24.h;

  @override
  void paint(Canvas canvas, Size size) {
    final screenUtil = ScreenUtil();

    double radius = 45;
    var paint = Paint();

    var x = 0.0;
    var y = Get.locale?.languageCode.compareTo('ar') == 0 ? 25.h : 21.h;
    var width = size.width;
    var height = size.height;
    var assetLength = list.length;
    var textPainterTotalWidth = 0.0;
    var maxTextPainterWidth = 0.0;
    // we should calculate the space needed for the text

    bool firstRounded = false;
    for (var asset in list) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: asset.name,
          style: TextStyle(
            fontSize: screenUtil.setSp(12),
            fontWeight: FontWeight.w500,
            color: unselectedBottomBarItemColorLightTheme,
            //fontFamily: FontFamily.inter,
          ),
        ),
        textDirection: TextDirection.ltr,
        textScaleFactor: screenUtil.textScaleFactor,
      );

      textPainter.layout();

      if (textPainter.width > maxTextPainterWidth) {
        maxTextPainterWidth = textPainter.width;
      }

      textPainterTotalWidth += textPainter.width + 15.w;
    }

    double oneAssetItemWidth = (width - textPainterTotalWidth.w) / 2.w;
    double marginAfterItem = ((width - textPainterTotalWidth) / 2.w);
    // oneAssetItemWidth -= marginAfterItem / 2.w;
    double currentMargin = marginAfterItem / 2.w;

    for (var asset in list) {
      // Here we will draw the circles
      final circleRadius = 5.h;
      var center = Offset(oneAssetItemWidth + (circleRadius / 2), 0);
      paint
        ..color = asset.color
        ..style = PaintingStyle.fill;

      // canvas.drawCircle(center, circleRadius, paint);

      // draw the text beside the circle
      final textPainter = TextPainter(
        text: TextSpan(
          text: asset.name,
          style: TextStyle(
            fontSize: screenUtil.setSp(12),
            fontWeight: FontWeight.w500,
            color: unselectedBottomBarItemColorLightTheme,
            //fontFamily: FontFamily.inter,
          ),
        ),
        textDirection: TextDirection.ltr,
        textScaleFactor: screenUtil.textScaleFactor,
      );

      textPainter.layout();

      // draw the rectangles
      bool isLast = list.indexOf(asset) == (list.length - 1);
      bool isFirst = list.first == (asset);

      paint.color = asset.color;
      // firstRounded = asset.percent > 0 ? true : false;
      var rect = Rect.fromLTWH(x, y + 7.h, width * asset.percent, 24.h);
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          rect,
          topLeft: Radius.circular(isFirst ? radius : 0),
          bottomLeft: Radius.circular(isFirst ? radius : 0),
          topRight: Radius.circular(isLast ? radius : 0),
          bottomRight: Radius.circular(isLast ? radius : 0),
        ),
        paint,
      );

      center = Offset(oneAssetItemWidth + (circleRadius / 2), (110.h) / 2);
      paint
        ..color = asset.color
        ..style = PaintingStyle.fill;

      // canvas.drawCircle(center, circleRadius, paint);

      // draw the text value of the asset
      final textValuePainter = TextPainter(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${currency}{asset.value}\n',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: unselectedBottomBarItemColorLightTheme,
                //fontFamily: FontFamily.inter,
              ),
            ),
          ],
          text: '${asset.percent * 100}%\n',
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: unselectedBottomBarItemColorLightTheme,
            //fontFamily: FontFamily.inter,
          ),
        ),
        textDirection: TextDirection.ltr,
        textScaleFactor: screenUtil.textScaleFactor,
      );

      textValuePainter.layout();

      var xOffset =
          oneAssetItemWidth + (circleRadius / 2) - textValuePainter.width / 2;
      var yOffset = (110.h + textPainter.height) / 2;
      // textValuePainter.paint(canvas, Offset(xOffset, yOffset));

      // currentMargin += (textPainterTotalWidth / assetLength) / 3.w;
      oneAssetItemWidth += currentMargin * assetLength;
      x += width * asset.percent;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
