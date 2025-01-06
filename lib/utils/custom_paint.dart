import 'package:flutter/material.dart';

class CurvedLinePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  CurvedLinePainter({required this.color, this.strokeWidth = 5});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height); // Start at the bottom-left corner
    path.quadraticBezierTo(
      size.width / 2, // Control point (middle of the width)
      -size.height, // Control point (above the container to create the curve)
      size.width, // End at the bottom-right corner
      size.height,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CurvedLine extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double strokeWidth;

  const CurvedLine({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
    this.strokeWidth = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: CurvedLinePainter(color: color, strokeWidth: strokeWidth),
    );
  }
}