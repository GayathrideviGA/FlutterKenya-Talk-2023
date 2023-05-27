import 'package:flutter/material.dart';
import 'package:getting_started_custom_paint_flutter/graph_painter.dart';

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
  final dataPoints = [
    const Offset(50, 100),
    const Offset(100, 50),
    const Offset(150, 200),
    const Offset(200, 150),
    const Offset(250, 100),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
            width: 600,
            height: 600,
            child: GraphWidget(dataPoints),
          ),
        ),
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
