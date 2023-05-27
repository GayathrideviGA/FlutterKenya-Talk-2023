import 'package:flutter/material.dart';

void main() {
  runApp(const FirstPaint());
}

/// The main widget for the custom paint example.
class FirstPaint extends StatefulWidget {
  const FirstPaint({Key? key}) : super(key: key);

  @override
  State<FirstPaint> createState() => _FirstPaintState();
}

class _FirstPaintState extends State<FirstPaint> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomPaint(
        painter: DrawALine(),
      ),
    );
  }
}

/// A custom painter that draws a line from the top left corner to the bottom right corner.
class DrawALine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw a line from the top left corner to the bottom right corner.
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0;
    canvas.drawLine(
        const Offset(0.0, 0.0), Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Return true if the painter needs to be repainted.
    return true;
  }
}
