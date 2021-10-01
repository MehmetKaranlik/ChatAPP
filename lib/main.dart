import 'package:chat_app_example/global_widgets/global_widgets.dart';
import 'package:chat_app_example/views/chat_view.dart/chat_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'views/views.dart';

SharedPreferences? pref;
var directedPage;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await asynInit();
  runApp(MyApp());
}

Future<void> asynInit() async {
  pref = await SharedPreferences.getInstance();

  if (pref!.getString(HelperFunctions.sharedPreferencesUserPasswordKey) !=
          null &&
      pref!.getString(HelperFunctions.sharedPreferencesUserEmailKey) != null) {
    directedPage = RoomPage();
    print(directedPage);
  } else {
    directedPage = SignInView();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => directedPage),
        ],
      );
    });
  }
}
