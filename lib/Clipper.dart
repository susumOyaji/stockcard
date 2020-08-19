import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 9.0;

    var path = Path();

    debugPrint("size.width: " + size.width.toString());
    debugPrint("size.height: " + size.height.toString());
    path.moveTo(0.0, 0.0); //P0

    path.lineTo(size.width - radius * 3.0, 0.0); //P2
    path.arcToPoint(Offset(size.width - radius, size.height), //P2 to P3
        clockwise: false,
        radius: Radius.circular(radius));

    //path.lineTo(size.width, size.height - radius); //P4
    //path.arcToPoint(Offset(size.width - radius, size.height), //P4 to P5
    //    clockwise: true,
    //    radius: Radius.circular(radius));

    path.lineTo(250.0, size.height); //P6
    path.arcToPoint(Offset(240.0, size.height - radius), // P7
        clockwise: true,
        radius: Radius.circular(radius));
    path.lineTo(240.0, size.height * 0.75); //P8

    path.lineTo(radius, size.height * 0.75); //P9
    path.arcToPoint(Offset(0.0, size.height * 0.75 - radius), //P10
        clockwise: true,
        radius: Radius.circular(radius));

    path.lineTo(0.0, radius); //P11
    path.arcToPoint(Offset(radius, 0.0), //P1
        clockwise: true,
        radius: Radius.circular(radius));

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
