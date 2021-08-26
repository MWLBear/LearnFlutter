import 'package:flutter/material.dart';
class CurvePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTRB(0, 300, 100, 400),Paint()..color = Colors.red);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}