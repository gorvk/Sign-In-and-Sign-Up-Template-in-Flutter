import 'package:flutter/material.dart';

class Palette {
  static const Color lightBlue = Color(0xff489FB5);
  static const Color darkBlue = Color(0xff092E34);
  static const Color orange = Color(0xffFFA62B);
}

class SigninBackgroundPainter extends CustomPainter {
  final Paint bluePaint;
  final Paint greyPaint;
  final Paint orangePaint;

  SigninBackgroundPainter()
      : bluePaint = Paint()
          ..color = Palette.lightBlue
          ..style = PaintingStyle.fill,
        greyPaint = Paint()
          ..color = Palette.darkBlue
          ..style = PaintingStyle.fill,
        orangePaint = Paint()
          ..color = Palette.orange
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    paintBlue(canvas, size);
    paintGrey(canvas, size);
    paintOrange(canvas, size);
  }

  void paintBlue(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    _addPointsToPath(
      path,
      [
        Point(0, 0),
        Point(size.width / 2, size.height / 2),
        Point(size.width, size.height / 2),
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
    path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height / 2 - 50);
    _addPointsToPath(
      path,
      [
        Point(size.width / 2 - 130, size.height / 2),
        Point(size.width / 2 - 10, size.height / 2 - 10),
        Point(size.width / 2 + 30, size.height / 2 - 160),
        Point(size.width - 20, 120),
        Point(size.width, 100),
      ],
    );
    canvas.drawPath(path, greyPaint);
  }

  void paintOrange(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width - 80, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height / 4);
    // path.close();
    _addPointsToPath(
      path,
      [
        Point(30, size.height / 4),
        Point(100, size.height / 4 - 100),
        Point(size.width - 100, 30),
        Point(size.width - 80, 0),
      ],
    );
    canvas.drawPath(path, orangePaint);
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
