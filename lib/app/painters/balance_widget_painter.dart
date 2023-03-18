import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BalanceWidgetPainter extends CustomPainter {
  final Color color;
  final double? lineWidth;

  BalanceWidgetPainter({
    required this.color,
  }) : lineWidth = 24.h;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 3.5.w;
    final center = Offset(size.width / 2, size.height / 8);
    final paint = Paint()
      ..strokeWidth = 15
      ..color = color
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius), pi, pi, false, paint);

    paint.style = PaintingStyle.fill;
    var rect = Rect.fromCenter(
        center: center, width: size.width - (radius / 2), height: 28.h);
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rect,
        topLeft: const Radius.circular(15),
        bottomLeft: const Radius.circular(15),
        topRight: const Radius.circular(15),
        bottomRight: const Radius.circular(15),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
