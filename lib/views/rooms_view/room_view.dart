import 'package:chat_app_example/global_widgets/global_widgets.dart';
import 'package:chat_app_example/services/Authentication/auth.dart';
import 'package:chat_app_example/services/database/database.dart';
import 'package:chat_app_example/views/rooms_view/rooms_widgets/search_button.dart';
import 'package:chat_app_example/views/search_view/search_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:chat_app_example/constants/constants.dart';
import 'package:chat_app_example/views/views.dart';

class RoomPage extends StatefulWidget {
  RoomPage({Key? key}) : super(key: key);

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late QuerySnapshot snapshotData;
  late String verifyEmail;
  final DatabaseMethods databaseMethods = DatabaseMethods();
  final AuthenticationMethods authMethods = AuthenticationMethods();
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  Future getUserInfo() async {
    if (await HelperFunctions().getUserNameSharedPreferences() == null) {
      await HelperFunctions.getUserEmailSharedPreferences().then((value) {
        setState(() {
          verifyEmail = value!;
        });
      });
      snapshotData = await databaseMethods.getUserByEmail(verifyEmail);
      setState(() {
        Constants.currentUsername = snapshotData.docs[0].get("name").toString();
      });
    } else {
      Constants.currentUsername =
          await HelperFunctions().getUserNameSharedPreferences().toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xff1F1F1F),
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(6.h),
            child: _buildTabBar(),
          ),
          centerTitle: true,
          leading: BackIconButton(onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            authMethods.signOut();
            Get.offAll(() => SignInView());
          }),
          actions: [
            SearchIconButton(onPressed: () => Get.off(() => SearchPage())),
            SizedPlaceHolder(
              height: 0.h,
              width: 2.w,
              color: Colors.transparent,
            ),
          ],
          backgroundColor: const Color(0xff1F1F1F),
          title: Text(
            "ChatApp",
            style: TextStyle(foreground: Paint()..shader = linearGradient),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(),
        ),
      ),
    );
  }

  TabBar _buildTabBar() {
    return const TabBar(
      indicatorColor: Colors.white60,
      automaticIndicatorColorAdjustment: false,
      labelColor: Colors.white60,
      tabs: [
        Tab(icon: Icon(Icons.message_outlined)),
        Tab(icon: Icon(Icons.call_rounded)),
      ],
    );
  }
}
