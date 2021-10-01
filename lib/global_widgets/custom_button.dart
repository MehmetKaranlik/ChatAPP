import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final onPressed;
  final Color labelColor;
  final double fontSize;
  final Color backGroundColor;
  final Color firstShaderColor;
  final Color secondShaderColor;
  final double buttonWidth;
  final bool isLogo;
  final String logoPath;

  const CustomTextButton(
      this.label,
      this.onPressed,
      this.labelColor,
      this.fontSize,
      this.backGroundColor,
      this.firstShaderColor,
      this.secondShaderColor,
      this.buttonWidth,
      this.isLogo,
      {required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [firstShaderColor, secondShaderColor],
      ).createShader(bounds),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(7),
        ),
        child: TextButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(Size.fromWidth(buttonWidth)),
              backgroundColor: MaterialStateProperty.all(backGroundColor),
            ),
            onPressed: onPressed,
            child: !isLogo
                ? Text(
                    label,
                    style: TextStyle(
                      
                      color: labelColor,
                      fontSize: fontSize,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: labelColor,
                          fontSize: fontSize,
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Image.asset(
                        logoPath,
                        height: 19,
                      )
                    ],
                  )),
      ),
    );
  }
}
