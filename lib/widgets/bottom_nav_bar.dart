import 'package:dogs_case/constants/assets.dart';
import 'package:dogs_case/constants/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Function onTapBottomBar;
  final context;
  const CustomBottomNavBar(this.onTapBottomBar,this.context,{super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        children: [
          DrawLineWidget(context),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navButton(Assets.bottomHome, 'Home', 0, color: const Color(0xFF0055D3)),
                Container(
                  height: 30,
                  width: 2,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle, color: AppColors.mainBlack),
                ),
                _navButton(Assets.bottomSettings, 'Settings', 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _navButton(String iconStr, String title, int index, {Color? color}) {
    return InkWell(
      onTap: () => onTapBottomBar(index, context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [SvgPicture.asset(iconStr),
        SizedBox(height: 2,),
         Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),)],
      ),
    );
  }
}

class DrawLineWidget extends StatelessWidget {
  const DrawLineWidget(this.context, {super.key});
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: SizedBox(
        height: 100,
        child: CustomPaint(
          painter: NavCustomPainter(context),
        ),
      ),
    );
  }
}

class NavCustomPainter extends CustomPainter {
  NavCustomPainter(
    this.context, {
    this.borderRadius = 20,
  });

  final double borderRadius;
  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColors.mainGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    var paint = Paint()
      ..color = AppColors.bottombarBackground
      ..style = PaintingStyle.fill;
    double corner = 28;
    double mybuttonHeight = 100.0;
    double mybuttonWW = MediaQuery.of(context).size.width - 14;
    final radius = Radius.circular(corner);
    Path path = Path()
      ..moveTo(corner, 0)
      ..lineTo(mybuttonWW - corner + 10, 0)
      ..arcToPoint(
        //left top
        Offset(mybuttonWW, corner),
        radius: radius,
      )
      ..lineTo(mybuttonWW + 15, mybuttonHeight) //left bottom corner
      ..arcToPoint(
        Offset(0, mybuttonHeight),
        radius: radius,
      )
      ..lineTo(15, corner - 5)
      ..arcToPoint(
        Offset(corner, 0),
        radius: radius,
      );

    canvas.drawPath(path, paint);

    final points = [
      const Offset(-5, 120),
      const Offset(20, 0),
      Offset(MediaQuery.of(context).size.width - 20, 0),
      Offset(MediaQuery.of(context).size.width + 5, 120),
    ];

    final (lines, arcs) = getLinesAndArcs(points, borderRadius: borderRadius);

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final arc = arcs[i];

      canvas.drawLine(line.start, line.end, paint0);
      canvas.drawArc(Rect.fromCircle(center: arc.center, radius: arc.radius),
          arc.startAngle, arc.sweepAngle, false, paint0);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double getLength(double dx, double dy) {
    return math.sqrt(dx * dx + dy * dy);
  }

  List<List<Offset>> getVerticeTriplets(List<Offset> points) {
    final triplets = <List<Offset>>[];

    for (var i = 0; i < points.length; i += 1) {
      final triplet = <Offset>[];
      for (var j = 0; j < 3; j++) {
        triplet.add(points[(i + j) % points.length]);
      }
      triplets.add(triplet);
    }

    return triplets;
  }

  (List<Line>, List<Arc>) getLinesAndArcs(
    List<Offset> points, {
    double borderRadius = 20,
  }) {
    var radius = borderRadius;

    final starts = <Offset>[];
    final ends = <Offset>[];

    final arcs = <Arc>[];

    final triplets = getVerticeTriplets(points);

    for (var i = 0; i < triplets.length; i++) {
      final [p1, angularPoint, p2] = triplets[i];

      //Vector 1
      final dx1 = angularPoint.dx - p1.dx;
      final dy1 = angularPoint.dy - p1.dy;

      //Vector 2
      final dx2 = angularPoint.dx - p2.dx;
      final dy2 = angularPoint.dy - p2.dy;

      final angle = (math.atan2(dy1, dx1) - math.atan2(dy2, dx2)) / 2;
      final tan = math.tan(angle).abs();
      var segment = radius / tan;

      final length1 = getLength(dx1, dy1);
      final length2 = getLength(dx2, dy2);

      final length = math.min(length1, length2);

      if (segment > length) {
        segment = length;
        radius = (length * tan);
      }

      var p1Cross =
          getProportionPoint(angularPoint, segment, length1, dx1, dy1);
      ends.add(p1Cross);
      var p2Cross =
          getProportionPoint(angularPoint, segment, length2, dx2, dy2);
      starts.add(p2Cross);

      final dx = angularPoint.dx * 2 - p1Cross.dx - p2Cross.dx;
      final dy = angularPoint.dy * 2 - p1Cross.dy - p2Cross.dy;

      final L = getLength(dx, dy);
      final d = getLength(segment, radius);

      final circlePoint = getProportionPoint(angularPoint, d, L, dx, dy);

      var startAngle =
          math.atan2(p1Cross.dy - circlePoint.dy, p1Cross.dx - circlePoint.dx);
      final endAngle =
          math.atan2(p2Cross.dy - circlePoint.dy, p2Cross.dx - circlePoint.dx);

      var sweepAngle = endAngle - startAngle;

      if (sweepAngle < 0) {
        startAngle = endAngle;
        sweepAngle = -sweepAngle;
      }

      if (sweepAngle > math.pi) sweepAngle = math.pi - sweepAngle;

      arcs.add(
        Arc(
          startAngle: startAngle,
          sweepAngle: sweepAngle,
          endAngle: endAngle,
          center: Offset(circlePoint.dx, circlePoint.dy),
          radius: radius,
        ),
      );
    }

    final lines = <Line>[];

    final shiftedStarts = [
      starts.last,
      ...starts.sublist(0, starts.length - 1)
    ];

    for (var i = 0; i < ends.length; i++) {
      lines.add(Line(start: shiftedStarts[i], end: ends[i]));
    }

    return (lines, [arcs.last, ...arcs.sublist(0, arcs.length - 1)]);
  }

  Offset getProportionPoint(
      Offset point, double segment, double length, double dx, double dy) {
    double factor = segment / length;

    return Offset((point.dx - dx * factor), (point.dy - dy * factor));
  }
}

class Arc {
  const Arc({
    required this.startAngle,
    required this.sweepAngle,
    required this.center,
    required this.radius,
    required this.endAngle,
  });

  final double startAngle;
  final double endAngle;
  final double sweepAngle;
  final Offset center;
  final double radius;
}

class Line {
  const Line({
    required this.start,
    required this.end,
  });

  final Offset start;
  final Offset end;
}
