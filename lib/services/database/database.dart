import 'dart:math';

import 'package:chat_app_example/constants/constants.dart';
import 'package:chat_app_example/controllers/controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late QuerySnapshot<Map> snapshotData;
  getUserByUsername(String username) async {
    await firebaseFirestore
        .collection("users")
        .where("name", isEqualTo: username)
        .get()
        .then((value) => snapshotData = value);

    return snapshotData;
  }

  Future<QuerySnapshot> getUserByEmail(String email) async {
    await firebaseFirestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .then((value) => snapshotData = value);
    return snapshotData;
  }

  upLoadUserInfo(userMap) async {
    await firebaseFirestore.collection("users").add(userMap);
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
    final checkUniqUser = await firebaseFirestore.collection("chatRoom").get();

    await firebaseFirestore
        .collection("chatRoom")
        .doc(chatRoomID)
        .set(chatRoomMap)
        .catchError((e) => print(e));
  }

  addConversationMessages(
      String chatRoomID, Map<String, dynamic> messageMap) async {
    final checkRoom = await firebaseFirestore
        .collection("chatRoom")
        .doc(chatRoomID)
        .collection("chats")
        .add(messageMap)
        .catchError((e) => print(e.toString()));
  }

  Stream getConversationMessages(String chatRoomID) {
    return firebaseFirestore
        .collection("chatRoom")
        .doc(chatRoomID)
        .collection("chats")
        .orderBy("timeStamp", descending: false)
        .snapshots();
  }

  createBinaryChatRoom(Map<String, String> Members) async {
    await firebaseFirestore.collection("chatRoom").doc().set(Members);
  }

  Future getSearchData(String input) async {
    return firebaseFirestore
        .collection("users")
        .where(input, isEqualTo: "name");
  }

  checkSharedRoom(Map<String, String> users) async {
    String? checkResult;
    final checkUniqUsername = await firebaseFirestore
        .collection("chatRoom")
        .where('user1', isEqualTo: users['user1'])
        .where('user2', isEqualTo: users['user2'])
        .get();
    final checkUniqqUsername = await firebaseFirestore
        .collection("chatRoom")
        .where('user2', isEqualTo: users['user1'])
        .where('user1', isEqualTo: users['user2'])
        .get();

    if (checkUniqUsername.docs.isEmpty && checkUniqqUsername.docs.isEmpty) {
      await createBinaryChatRoom(users);
    } else {
      if (checkUniqUsername.docs.isEmpty) {
        checkResult = checkUniqqUsername.docs[0].id;
      } else {
        checkResult = checkUniqUsername.docs[0].id;
      }
    }
    print(checkResult);
  }

  getConversationUniqueID(Map<String, String> users) async {
    String uniqueID;

    QuerySnapshot<Map<String, dynamic>> scenario1 = await firebaseFirestore
        .collection("chatRoom")
        .where('user1', isEqualTo: users['user1'])
        .where('user2', isEqualTo: users['user2'])
        .get();

    QuerySnapshot<Map<String, dynamic>> scenario2 = await firebaseFirestore
        .collection("chatRoom")
        .where('user2', isEqualTo: users['user1'])
        .where('user1', isEqualTo: users['user2'])
        .get();

    if (await scenario1 == null) {
      return uniqueID = await scenario2.docs[0].id;
    } else {
      return uniqueID = scenario1.docs[0].id;
    }
  }
}
