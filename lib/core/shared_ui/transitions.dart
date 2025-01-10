import 'package:flutter/material.dart';

Widget defaultFadeSlideTransition(Widget child, Animation<double> animation) {
  final opacity = CurvedAnimation(
    parent: animation,
    curve: Curves.easeOut,
  ).drive(Tween(begin: 0.0, end: 1.0));
  final slide = CurvedAnimation(
    parent: animation,
    curve: Curves.easeOut,
  ).drive(Tween(begin: Offset(0, 0.0075), end: Offset.zero));

  return SlideTransition(
    position: slide,
    child: FadeTransition(opacity: opacity, child: child),
  );
}
