import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BackIconButton extends StatelessWidget {
  final onPressed;
  const BackIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(colors: [
          Colors.purple,
          Colors.cyan,
        ]).createShader(bounds);
      },
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.backspace,
            color: Colors.white,
            size: 8.w,
          )),
    );
  }
}
