import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferencesUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferencesUserNameKey = "USERNAME_KEY";
  static String sharedPreferencesUserEmailKey = "USEREMAIL_KEY";
  static String sharedPreferencesUserPasswordKey = "PASSWORD_KEY";
  //Saving data to shared preferences

  static Future<bool> saveUserLoggedInSharedPreferences(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(
        sharedPreferencesUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreferences(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserNameKey, userName);
  }

  static Future<bool> saveUserPasswordSharedPreferences(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserPasswordKey, password);
  }

  static Future<bool> saveUserEmailSharedPreferences(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserEmailKey, userEmail);
  }

  // Getting data from shared preferences
  static Future<bool?> getUserLoggedInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(
      sharedPreferencesUserEmailKey,
    );
  }

  Future<String?> getUserNameSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
      sharedPreferencesUserNameKey,
    );
  }

  static Future<String?> getUserEmailSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
      sharedPreferencesUserEmailKey,
    );
  }

  static Future<String?> getUserPasswordSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
      sharedPreferencesUserPasswordKey,
    );
  }
}
