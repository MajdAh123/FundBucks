import 'package:flutter/material.dart';

class StretchedBottomNavigationBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    // Create a path that starts at the top-left corner of the canvas,
    // goes to the top-right corner, then down to the bottom-right corner,
    // and finally to the bottom-left corner.
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Create a path that starts at the bottom-left corner of the canvas,
    // goes up to the middle of the canvas at a height of half the canvas height,
    // then down to the bottom-right corner.
    Path middlePath = Path();
    middlePath.moveTo(0, 0);
    middlePath.lineTo(size.width / 2, -size.height / 8);
    middlePath.lineTo(size.width, 0);
    // middlePath.lineTo(0, size.height);
    middlePath.close();

    // Use the `color` property to set the color of the bottom navigation bar
    paint.color = Colors.white;

    // Use the `fillPath` method to fill the path with the specified color
    canvas.drawPath(path, paint);
    paint.color = Colors.white;
    canvas.drawPath(middlePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
