import 'package:chat_app_example/constants/constants.dart';
import 'package:chat_app_example/controllers/controllers.dart';
import 'package:chat_app_example/models/models.dart';
import 'package:chat_app_example/global_widgets/global_widgets.dart';
import 'package:chat_app_example/views/rooms_view/rooms_widgets/search_button.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../views.dart';

class ChatPage extends StatelessWidget {
  Color backgroundColor = AppBarColor().appBarColor;
  String imageUrl;
  String username;
  ChatPage({Key? key, required this.imageUrl, required this.username})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Container(
            width: 100.w,
            child: Column(), //text section
          ),
          const Spacer(),
          const _BuildBottomTextSection(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      titleSpacing: 8.w,
      leadingWidth: 40.w,
      centerTitle: true,
      leading: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BackIconButton(onPressed: () {
            Get.off(() => RoomPage());
          }),
          SizedPlaceHolder(height: 3.h, width: 6.w, color: Colors.transparent),
          CustomCircularAvatar(imageUrl: imageUrl, size: 6.w),
        ],
      ),
      actions: [
        SearchIconButton(onPressed: () => ""),
        SizedPlaceHolder(
          height: 0.h,
          width: 2.w,
          color: Colors.transparent,
        ),
      ],
      backgroundColor: const Color(0xff1F1F1F),
      title: Text(
        username,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

class _BuildBottomTextSection extends StatelessWidget {
  const _BuildBottomTextSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.white60, Colors.white70]),
        color: Colors.grey[600],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3.h),
          topRight: Radius.circular(3.h),
        ),
      ),
      child: Row(
        children: const [
          _BuildTextFormFieldChat(),
          _BuildIconSendButton(),
        ],
      ),
    );
  }
}

class _BuildTextFormFieldChat extends StatelessWidget {
  const _BuildTextFormFieldChat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 85.w,
      height: 7.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: TextFormField(
          controller: TextFieldControllers().chatTextFieldController,
          cursorHeight: 4.h,
          cursorColor: Colors.black54,
          decoration: const InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}

class _BuildIconSendButton extends StatelessWidget {
  const _BuildIconSendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => "",
      icon: ShaderMask(
        shaderCallback: (bounds) {
          return const LinearGradient(colors: [
            Colors.purple,
            Colors.cyan,
          ]).createShader(bounds);
        },
        child: Icon(
          Icons.send,
          size: 9.w,
          color: Colors.white,
        ),
      ),
    );
  }
}
