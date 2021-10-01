import 'package:flutter/material.dart';

class SizedPlaceHolder extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const SizedPlaceHolder(
      {required this.height, required this.width, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Placeholder(
        color: color,
      ),
    );
  }
}
