import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const AppLogo(this.size, {this.color});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          colors: [Colors.purple, Colors.cyan, Colors.pink],
        ).createShader(bounds);
      },
      child: Icon(
        Icons.maps_ugc_rounded,
        size: size,
        color: color,
      ),
    );
  }
}
