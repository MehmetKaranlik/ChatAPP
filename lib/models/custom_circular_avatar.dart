import 'package:flutter/material.dart';
import 'package:chat_app_example/constants/constants.dart';

class CustomCircularAvatar extends StatelessWidget {
  static Color avatarbackground = AppBarColor().appBarColor;
  final String imageUrl;
  final double size;

  CustomCircularAvatar({Key? key, required this.imageUrl, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: size,
        backgroundColor: avatarbackground,
        backgroundImage: imageUrl.isEmpty
            ? const NetworkImage(
                "https://www.pngkit.com/png/full/302-3022217_roger-berry-avatar-placeholder.png",
              )
            : NetworkImage(imageUrl));
  }
}
