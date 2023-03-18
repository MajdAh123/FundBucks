import 'package:app/app/utils/utils.dart';
import 'package:flutter/material.dart';

class CardWidgetPainter extends CustomPainter {
  final double percent;
  final double borderRadius;

  CardWidgetPainter({
    required this.percent,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paint paint = Paint();

    double w = size.width;
    double h = size.height;
    // double r = 15;

    var paint1 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill;

    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h),
      Radius.circular(borderRadius),
    );
    canvas.drawRRect(fullRect, paint1);

    Path middlePath = Path();
    middlePath.moveTo(0, size.height);
    middlePath.lineTo(size.width / 2, size.height / percent);
    middlePath.lineTo(size.width, size.height);
    middlePath.close();

    canvas.drawPath(middlePath, paint1);

    paint1.color = strokeColor;
    // paint1.style = PaintingStyle.fill; // Change this to fill
    paint1.strokeWidth = 2;
    paint1.strokeCap = StrokeCap.round;
    paint1.style = PaintingStyle.stroke;
    paint1.shader = const LinearGradient(
            colors: [Color.fromARGB(255, 168, 168, 168), Colors.white],
            stops: [0, 0.5],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)
        .createShader(Rect.fromLTRB(0, 0, size.width, size.height * 2));

    var path = Path();

    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(size.width / 2, size.height), paint1);

    paint1.shader = LinearGradient(
            colors: [Colors.white, linearGradientColor, Colors.white],
            stops: const [0, 0.5, 1],
            begin: Alignment.center,
            end: Alignment.centerRight)
        .createShader(
            Rect.fromLTRB(-size.width, 0, size.width, size.height * 2));

    canvas.drawLine(Offset(58, size.height / 2),
        Offset(size.width - 59, size.height / 2), paint1);

    // path.moveTo(size.width / 2, 0);
    // path.lineTo(size.width / 2, 0);
    // path.lineTo(size.width / 2, size.height);
    // // path.lineTo(size.width, size.height);
    // path.close();

    canvas.drawPath(path, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
