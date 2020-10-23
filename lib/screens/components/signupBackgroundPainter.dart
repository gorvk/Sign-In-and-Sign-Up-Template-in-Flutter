import 'package:flutter/material.dart';

class Palette {
  static const Color lightBlue = Color(0xff489FB5);
  static const Color darkBlue = Color(0xff092E34);
}

class SignupBackgroundPainter extends CustomPainter {
  final Paint bluePaint;
  final Paint greyPaint;

  SignupBackgroundPainter()
      : bluePaint = Paint()
          ..color = Palette.lightBlue
          ..style = PaintingStyle.fill,
        greyPaint = Paint()
          ..color = Palette.darkBlue
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    paintBlue(canvas, size);
    paintGrey(canvas, size);
  }

  void paintBlue(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2 + 100);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(100, size.height);
    _addPointsToPath(
      path,
      [
        Point(100, size.height + 10),
        Point(size.width / 2 - 20 , size.height - 100),
        Point(size.width / 2 + 120 , size.height/2 + 160),
        Point(size.width, size.height / 2 + 100),
      ],
    );
    canvas.drawPath(path, bluePaint);
    print("Half Height :${(size.height / 2)}");
    print("Half Width :${(size.width / 2)}");
    print("Height :${(size.height)}");
    print("Width :${(size.width)}");
  }

  void paintGrey(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2 + 100);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height / 2 + 30);
    _addPointsToPath(
      path,
      [
        Point(80 , size.height/2 -  50),
        Point(size.width / 2 + 100 , size.height/2 - 80),
        Point(size.width, size.height / 2 - 150),
      ],
    );
    canvas.drawPath(path, greyPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError("More than three points needed");
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }
    path.quadraticBezierTo(
      points[points.length - 2].x,
      points[points.length - 2].y,
      points[points.length - 1].x,
      points[points.length - 1].y,
    );
  }
}

class Point {
  final double x;
  final double y;
  Point(this.x, this.y);
}
