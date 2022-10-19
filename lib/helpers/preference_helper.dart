import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static void saveAuthPreferences(bool loggedIn, String username, String userId,
      String phone, String email) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("isLoggedIn", loggedIn);
    _prefs.setString("userName", username);
    _prefs.setString("userId", userId);
    _prefs.setString("phone", phone);
    _prefs.setString("email", email);
  }

  static void clearPreferences() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }
}
