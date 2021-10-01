import 'package:chat_app_example/global_widgets/global_widgets.dart';
import 'package:chat_app_example/services/database/database.dart';
import 'package:chat_app_example/views/chat_view.dart/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchTile extends StatelessWidget {
  final onPressed;
  final String username;
  final String email;
  final String imageUrl;

  const SearchTile(
      {Key? key,
      required this.username,
      required this.email,
      required this.imageUrl,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 10.h,
      child: Card(
        color: Colors.grey[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.h)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(username),
                  Text(email),
                ],
              ),
              Container(
                width: 25.w,
                child: CustomTextButton(
                    "Message",
                    onPressed,
                    Colors.black54,
                    12.sp,
                    Colors.white,
                    Colors.purple,
                    Colors.cyan,
                    11.sp,
                    false,
                    logoPath: ""),
              )
            ],
          ),
        ),
      ),
    );
  }
}
