import 'package:flutter/material.dart';

class AuthHeaderClipper extends CustomClipper<Path> {
  const AuthHeaderClipper();

  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height * 0.82)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.62,
        size.width,
        size.height * 0.82,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
