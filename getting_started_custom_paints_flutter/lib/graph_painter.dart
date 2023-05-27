// import 'package:flutter/material.dart';

// class GraphPainter extends CustomPainter {
//   final List<Offset> dataPoints;

//   GraphPainter(this.dataPoints);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;

//     final path = Path();

//     // Draw x-axis
//     path.moveTo(0, size.height);
//     path.lineTo(size.width, size.height);

//     // Draw y-axis
//     path.moveTo(0, 0);
//     path.lineTo(0, size.height);

//     // Draw data points
//     for (final point in dataPoints) {
//       path.addOval(Rect.fromCircle(center: point, radius: 4));
//     }

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

/// TO Add interactivity

import 'package:flutter/material.dart';

class GraphWidget extends StatefulWidget {
  final List<Offset> dataPoints;

  const GraphWidget(this.dataPoints, {super.key});

  @override
  _GraphWidgetState createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  Offset origin = const Offset(0, 0);
  double scale = 1.0;
  double previousScale = 1.0;
  Offset startFocalPoint = Offset.zero;

  void _handleScaleStart(ScaleStartDetails details) {
    previousScale = scale;
    startFocalPoint = details.localFocalPoint;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    final scaleDelta = details.scale - previousScale;
    final midpoint = (startFocalPoint + details.localFocalPoint) / 2;

    setState(() {
      origin = startFocalPoint - midpoint;
      scale = scaleDelta + previousScale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: _handleScaleStart,
      onScaleUpdate: _handleScaleUpdate,
      child: CustomPaint(
        painter: GraphPainter(widget.dataPoints, origin, scale),
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  final List<Offset> dataPoints;
  final Offset origin;
  final double scale;

  GraphPainter(this.dataPoints, this.origin, this.scale);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Draw x-axis
    final adjustedX = origin.dx * scale;
    final y = size.height / 2 + origin.dy * scale;
    path.moveTo(0, y);
    path.lineTo(size.width, y);

    // Draw y-axis
    final x = size.width / 2 + adjustedX;
    path.moveTo(x, 0);
    path.lineTo(x, size.height);

    // Draw data points
    for (final point in dataPoints) {
      final adjustedPoint =
          Offset(point.dx * scale + adjustedX, point.dy * scale);
      path.addOval(Rect.fromCircle(center: adjustedPoint, radius: 4));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
