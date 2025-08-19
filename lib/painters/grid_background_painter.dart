import 'package:flutter/material.dart';

class GridBackgroundPainter extends CustomPainter {
  final double gridSize;
  final Color lineColor;
  final double strokeWidth;

  GridBackgroundPainter({
    this.gridSize = 32.0,
    this.lineColor = const Color(0xFFE0E0E0),
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Draw vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(GridBackgroundPainter oldDelegate) {
    return gridSize != oldDelegate.gridSize ||
        lineColor != oldDelegate.lineColor ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}
