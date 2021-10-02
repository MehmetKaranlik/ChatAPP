import 'dart:math';

import 'package:chat_app_example/controllers/controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  late QuerySnapshot<Map> snapshotData;
  getUserByUsername(String username) async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get()
        .then((value) => snapshotData = value);

    return snapshotData;
  }

  Future<QuerySnapshot> getUserByEmail(String email) async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .then((value) => snapshotData = value);
    return snapshotData;
  }

  upLoadUserInfo(userMap) async {
    await FirebaseFirestore.instance.collection("users").add(userMap);
  }

  getChatRoomId(String a, String b) {
    print(a + " to " + b);
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoom(String chatRoomID, chatRoomMap) async {
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomID)
        .set(chatRoomMap)
        .catchError((e) => print(e));
  }

  addConversationMessages(
      String chatRoomID, Map<String, dynamic> messageMap) async {
    await FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomID)
        .collection("chats")
        .add(messageMap)
        .catchError((e) => print(e.toString()));
  }

  Stream getConversationMessages(String chatRoomID) {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomID)
        .collection("chats")
        .orderBy("timeStamp", descending: false)
        .snapshots();
  }
}
