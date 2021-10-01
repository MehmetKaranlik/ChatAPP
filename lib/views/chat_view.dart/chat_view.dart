import 'package:chat_app_example/constants/constants.dart';
import 'package:chat_app_example/controllers/controllers.dart';
import 'package:chat_app_example/models/models.dart';
import 'package:chat_app_example/global_widgets/global_widgets.dart';
import 'package:chat_app_example/services/database/database.dart';
import 'package:chat_app_example/views/rooms_view/rooms_widgets/search_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../views.dart';

class ChatPage extends StatelessWidget {
  DatabaseMethods _databaseMethods = DatabaseMethods();
  TextFieldControllers _controllers = TextFieldControllers();
  Color backgroundColor = AppBarColor().appBarColor;
  String chatRoomID;
  String imageUrl;
  String username;
  ChatPage(
      {Key? key,
      required this.imageUrl,
      required this.username,
      required this.chatRoomID})
      : super(key: key);

  /*Widget chatMessageList() {
     print("anan");
  }*/

  sendMessage() {
    Map<String, String> messageMap = {
      "message": _controllers.chatTextFieldController.text,
      "sendBy": Constants.currentUsername!
    };
    _databaseMethods.getConversationMessages(chatRoomID, messageMap);
  }

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
          Container(
            decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.white60, Colors.white70]),
              color: Colors.grey[600],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3.h),
                topRight: Radius.circular(3.h),
              ),
            ),
            child: Row(
              children: [
                _buildTextFormField(_controllers.chatTextFieldController),
                IconButton(
                  onPressed: () {
                    if (_controllers.chatTextFieldController.text != null) {
                      sendMessage();
                    }
                  },
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
                ),
              ],
            ),
          ),
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

Container _buildTextFormField(TextEditingController controller) {
  return Container(
    width: 85.w,
    height: 7.h,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: TextFormField(
        controller: controller,
        cursorHeight: 4.h,
        cursorColor: Colors.black54,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(borderSide: BorderSide.none)),
      ),
    ),
  );
}
