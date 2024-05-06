import 'package:shared_preferences/shared_preferences.dart';

enum SessionKey { token, newUser }

Map<SessionKey, String> sessionMap = {
  SessionKey.token: 'token',
  SessionKey.newUser: 'newUser',
};

class SessionService {
  static Future<SharedPreferences> initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static setString(SessionKey key, String value) async {
    SharedPreferences prefs = await initialize();
    prefs.setString(sessionMap[key] ?? '', value);
  }

  static getString(SessionKey key) async {
    SharedPreferences prefs = await initialize();
    return prefs.getString(sessionMap[key] ?? '');
  }

  static setBool(SessionKey key, bool value) async {
    SharedPreferences prefs = await initialize();
    prefs.setBool(sessionMap[key] ?? '', value);
  }

  static getBool(SessionKey key) async {
    SharedPreferences prefs = await initialize();
    return prefs.getBool(sessionMap[key] ?? '');
  }

  static clearAll() async {
    SharedPreferences prefs = await initialize();
    prefs.clear();
  }
}
