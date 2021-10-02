import 'package:chat_app_example/constants/constants.dart';
import 'package:chat_app_example/controllers/controllers.dart';
import 'package:chat_app_example/global_widgets/global_widgets.dart';
import 'package:chat_app_example/services/database/database.dart';
import 'package:chat_app_example/views/chat_view.dart/chat_view.dart';
import 'package:chat_app_example/views/rooms_view/rooms_widgets/search_button.dart';
import 'package:chat_app_example/views/search_view/search_view_widgets/search_list_tile.dart';
import 'package:chat_app_example/views/views.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';
import 'package:chat_app_example/services/database/database.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String appUser = Constants.currentUsername.toString();
  final DatabaseMethods _databaseMethods = DatabaseMethods();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final obxController = Get.put(IsSearchedController());
  final TextFieldControllers _controllerInstance = TextFieldControllers();
  QuerySnapshot<Map<String, dynamic>>? snapshotData;

  Future getSearchData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("name",
            isEqualTo: _controllerInstance.searchTextFieldController.text)
        .get()
        .then((value) {
      return snapshotData = value;
    });
    return snapshotData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F1F1F),
      appBar: _buildAppbar(),
      body: Column(
        children: [
          Container(
            color: Colors.grey[400],
            width: 100.w,
            height: 7.5.h,
            child: TextFormField(
              controller: _controllerInstance.searchTextFieldController,
              cursorColor: const Color(0xff1F1F1F),
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                  disabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff1F1F1F),
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff1F1F1F),
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff1F1F1F),
                    ),
                  ),
                  suffixIcon: SearchIconButton(
                    onPressed: () async {
                      await getSearchData();
                      obxController.changeIsSearched();
                    },
                  ),
                  hintText: "Search",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8)),
            ),
          ),
          Obx(
            () => obxController.isSearched
                ? const SizedBox.shrink()
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshotData!.docs.length,
                    itemBuilder: (context, index) {
                      return SearchTile(
                        onPressed: _buildMessageButtonOnPressed,
                        imageUrl: "",
                        username: snapshotData!.docs[index].data()["name"],
                        email: snapshotData!.docs[index].data()["email"],
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  _buildMessageButtonOnPressed() async {
    String userName = snapshotData!.docs[0].data()["name"];
    String? _uniqueID;

    if (Constants.currentUsername != userName) {
      Map<String, String> members = {
        "user1": Constants.currentUsername!,
        "user2": userName
      };
      await _databaseMethods.checkSharedRoom(members);

      //print(await _databaseMethods.checkSharedRoom(userName));

      // await _databaseMethods
      //   .createBinaryChatRoom(members); //create docs in "chatRoom" Collection
      _uniqueID = await _databaseMethods.getConversationUniqueID(members);
      Get.off(() =>
          ChatPage(imageUrl: "", username: userName, chatRoomID: _uniqueID!));
    } else {
      print("username=currentusername");
    }
  }

  InputDecoration decaritoin() {
    return InputDecoration(
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff1F1F1F),
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff1F1F1F),
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff1F1F1F),
          ),
        ),
        suffixIcon: SearchIconButton(onPressed: () {}),
        hintText: "Search",
        contentPadding: const EdgeInsets.symmetric(horizontal: 8));
  }

  AppBar _buildAppbar() {
    return AppBar(
      centerTitle: true,
      leading: BackIconButton(onPressed: () => Get.off(RoomPage())),
      actions: [
        SizedPlaceHolder(
          height: 0.h,
          width: 2.w,
          color: Colors.transparent,
        ),
      ],
      backgroundColor: const Color(0xff1F1F1F),
      title: Text(
        "ChatApp",
        style: TextStyle(
            foreground: Paint()..shader = AppBarColor().linearGradient),
      ),
    );
  }
}
