import 'package:chat_app_example/constants/constants.dart';
import 'package:chat_app_example/controllers/controllers.dart';
import 'package:chat_app_example/models/models.dart';
import 'package:chat_app_example/global_widgets/global_widgets.dart';
import 'package:chat_app_example/services/database/database.dart';
import 'package:chat_app_example/views/chat_view.dart/chat_view_widgets/message_tile.dart';
import 'package:chat_app_example/views/rooms_view/rooms_widgets/search_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../views.dart';

class ChatPage extends StatefulWidget {
  final String chatRoomID;
  final String imageUrl;
  final String username;
  ChatPage(
      {Key? key,
      required this.imageUrl,
      required this.username,
      required this.chatRoomID})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final DatabaseMethods _databaseMethods = DatabaseMethods();
  final TextFieldControllers _controllers = TextFieldControllers();
  final Color backgroundColor = AppBarColor().appBarColor;
  Stream? chatMessageStream;
  Widget chatList() {
    return StreamBuilder(
      stream: chatStream(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: (snapshot.data as QuerySnapshot).docs.length,
            itemBuilder: (context, index) {
              print((snapshot.data as QuerySnapshot).docs[index]["message"]);
              return MessageTile(
                message: (snapshot.data as QuerySnapshot).docs[index]
                    ["message"],
                isSendByMe: (snapshot.data as QuerySnapshot).docs[index]
                        ["sendBy"] ==
                    Constants.currentUsername,
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  sendMessage() {
    Map<String, dynamic> messageMap = {
      "message": _controllers.chatTextFieldController.text,
      "sendBy": Constants.currentUsername!,
      "timeStamp": DateTime.now().millisecondsSinceEpoch,
    }; //Message Model Map
    if (_controllers.chatTextFieldController.text.isNotEmpty) {
      _databaseMethods.addConversationMessages(
        widget.chatRoomID,
        messageMap,
      );
    }
    _controllers.chatTextFieldController.clear();
  } // sending a message

  @override
  void initState() {
    super.initState();
  }

  Stream chatStream() {
    return _databaseMethods.getConversationMessages(widget.chatRoomID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(child: chatList()),

          _buildTextFieldAndSendButton(), // TextField and Send message button
        ],
      ),
    );
  }

  Container _buildTextFieldAndSendButton() {
    return Container(
      height: 10.h,
      decoration: BoxDecoration(
        gradient:
            const LinearGradient(colors: [Colors.white60, Colors.white70]),
        color: Colors.grey[600],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3.h),
          topRight: Radius.circular(3.h),
        ),
      ),
      child: Row(
        children: [
          _buildTextFormField(_controllers.chatTextFieldController),
          _buildSendButton(),
        ],
      ),
    );
  }

  IconButton _buildSendButton() {
    return IconButton(
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
          CustomCircularAvatar(imageUrl: widget.imageUrl, size: 6.w),
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
        widget.username,
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
