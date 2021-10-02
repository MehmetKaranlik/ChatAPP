import 'package:chat_app_example/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  const MessageTile({Key? key, required this.message, required this.isSendByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isSendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(1.5.h),
            margin: EdgeInsets.all(1.h),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: isSendByMe ? Colors.blue[400] : Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(2.w),
              ),
            ),
            height: 7.h,
            constraints: BoxConstraints(
              minWidth: 15.w,
            ),
            child: Text(
              message,
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ]);
  }
}
