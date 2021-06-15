import 'package:flutter/material.dart';

class OrangeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height * 0.4);

    var firstControlPoint = Offset(size.width * 0.25, size.height * 0.45);
    var firstEndPoint = Offset(size.width * 0.5, size.height * 0.4);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 0.80, size.height * 0.33);
    var secondEndPoint = Offset(size.width * 0.9, size.height * 0.23);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset(size.width * 0.929, size.height * 0.205);
    var thirdEndPoint = Offset(size.width, size.height * 0.2);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(size.width, size.height * 0.2);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class GreenClipper extends CustomClipper<Path> {
  /// reverse the wave direction in vertical axis
  bool reverse;

  GreenClipper({
    this.reverse = false,
  });

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height * 0.77);

    var firstControlPoint = Offset(size.width * 0.28, size.height * 0.76);
    var firstEndPoint = Offset(size.width * 0.3, size.height * 0.68);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 0.35, size.height * 0.52);
    var secondEndPoint = Offset(size.width * 0.55, size.height * 0.545);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = Offset(size.width * 0.5, size.height * 0.538);
    var thirdEndPoint = Offset(size.width, size.height * 0.6);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
