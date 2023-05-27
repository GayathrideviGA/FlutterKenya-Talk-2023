import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Custom painting logic here based on the provided canvas and size
    // Use canvas methods to draw shapes, lines, text, etc.
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Return true if the painter should repaint when the data changes,
    // otherwise return false to optimize rendering.
    return false;
  }
}

class DrawWithLayer extends StatelessWidget {
  const DrawWithLayer({super.key});

  @override
  Widget build(BuildContext context) {
    final recorder = PictureRecorder();
    final canvas = Canvas(recorder);

    // Render the data onto a separate layer (e.g., PictureLayer)
    MyCustomPainter().paint(canvas, const Size(200, 200));
    final picture = recorder.endRecording();

    return CustomPaint(
      painter:
          PictureLayerPainter(picture), // Custom painter for the separate layer
      child: Container(), // Your other widgets here
    );
  }
}

class PictureLayerPainter extends CustomPainter {
  final Picture picture;

  PictureLayerPainter(this.picture);

  @override
  void paint(Canvas canvas, Size size) {
    // Render the separate layer onto the screen using the provided canvas
    canvas.drawPicture(picture);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Return true if the painter should repaint when the data changes,
    // otherwise return false to optimize rendering.
    return false;
  }
}
