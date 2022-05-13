
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class CircleBack extends CustomPainter {


  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blue;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.fill;

    canvas.drawCircle(Offset.zero, 100, paint);

    paint.color = Colors.black26;
    paint.strokeWidth = 10;
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(Offset.zero, 105, paint);



  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

class CircleProgress extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    // paint.color = Colors.green;
    paint.strokeWidth = 5;
    paint.style = PaintingStyle.stroke;
    // canvas.drawCircle(Offset.zero, 105, paint);

    double length = pi * 2;
    double endAngle = length * 50 / 100;
    double startAngle = pi / 2;
    Rect rect = Rect.fromCircle(center: Offset.zero, radius: 105);
    paint.shader = const SweepGradient(colors: [Colors.greenAccent,Colors.white70],stops: [0,1],endAngle: pi,transform: GradientRotation(pi / 2)).createShader(rect);
    canvas.drawArc(rect, startAngle, endAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

class CirclePaint extends CustomPaint {
  const CirclePaint({Key? key}) : super(key: key);

  @override
  CustomPainter? get painter => CircleBack();

  @override
  CustomPainter? get foregroundPainter => CircleProgress();

  Future<int> test() async {
    sleep(const Duration(minutes: 2));
    return 0;
  }
}