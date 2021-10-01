import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppBarColor {
  Color appBarColor = const Color(0xff1F1F1F);
}

final Shader linearGradient = const LinearGradient(
  // appBar title gradient
  colors: <Color>[Colors.purple, Colors.cyan, Colors.pink],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 63.w, 1.h),
);
