import 'package:flutter/material.dart';

class Constants {
  static String? currentUsername;

  static SnackBar loginErrorSnackBar = const SnackBar(
    content: Text(
      "Wrong email or password",
      style: TextStyle(color: Colors.red),
    ),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.white,
  );
  static SnackBar RegisterErrorSnackBar = const SnackBar(
    content: Text(
      "E-mail already in use ",
      style: TextStyle(color: Colors.red),
    ),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.white,
  );
}
