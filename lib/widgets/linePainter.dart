import 'package:flutter/material.dart';

class LinePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFAFAFAF)
      ..strokeWidth= 2;
    canvas.drawLine(Offset(3,1), Offset(3,29), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=> false;
}
