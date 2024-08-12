
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Layer 1

    Paint paintFill0 = Paint()
      ..color = const Color.fromRGBO(173, 89, 31, 200)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width * -0.0011111, size.height * 1.0100000);
    path_0.quadraticBezierTo(size.width * 0.0855556, size.height * 0.7275000,
        size.width * 0.1677778, size.height * 0.7400000);
    path_0.cubicTo(
        size.width * 0.2475000,
        size.height * 0.7450000,
        size.width * 0.3769444,
        size.height * 0.9350000,
        size.width * 0.4466667,
        size.height);
    path_0.cubicTo(
        size.width * 0.5047222,
        size.height * 1.0550000,
        size.width * 0.6541667,
        size.height * 0.8050000,
        size.width * 0.7233333,
        size.height * 0.7400000);
    path_0.quadraticBezierTo(size.width * 0.8161111, size.height * 0.6400000,
        size.width * 1.0011111, size.height);
    path_0.lineTo(size.width * 0.9988889, size.height * -0.0050000);
    path_0.lineTo(0, 0);
    path_0.close();

    canvas.drawPath(path_0, paintFill0);

    // Layer 1

    Paint paintStroke0 = Paint()
      ..color = const Color.fromRGBO(173, 89, 31, 200)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_0, paintStroke0);

    // Layer 1

    Paint paintFill1 = Paint()
      ..color = const Color.fromRGBO(173, 89, 35, 100)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9988889, size.height * -0.0150000);
    path_1.lineTo(size.width, size.height * 0.7550000);
    path_1.quadraticBezierTo(size.width * 0.9266667, size.height * 1.0162500,
        size.width * 0.7777778, size.height * 1.0100000);
    path_1.cubicTo(
        size.width * 0.6333333,
        size.height * 0.9750000,
        size.width * 0.5302778,
        size.height * 0.8000000,
        size.width * 0.4477778,
        size.height * 0.7300000);
    path_1.cubicTo(
        size.width * 0.3152778,
        size.height * 0.6887500,
        size.width * 0.2369444,
        size.height * 0.9362500,
        size.width * 0.1666667,
        size.height * 1.0050000);
    path_1.quadraticBezierTo(size.width * 0.0972222, size.height * 1.0262500, 0,
        size.height * 0.7500000);
    path_1.lineTo(0, size.height * -0.0050000);
    path_1.lineTo(size.width * 0.9988889, size.height * -0.0150000);
    path_1.close();

    canvas.drawPath(path_1, paintFill1);

    // Layer 1

    Paint paintStroke1 = Paint()
      ..color = const Color.fromRGBO(173, 89, 35, 100)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paintStroke1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomBackGround extends StatelessWidget {
  CustomBackGround({super.key, required this.child});
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(
              Get.width,
              Get.height *
                  0.12), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
        ),
        child
      ],
    );
  }
}
