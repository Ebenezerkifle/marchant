import 'package:shared_preferences/shared_preferences.dart';

enum SessionKey { token }

Map<SessionKey, String> sessionMap = {
  SessionKey.token: 'token',
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

  static setBool(String key, bool value) async {
    SharedPreferences prefs = await initialize();
    prefs.setBool(key, value);
  }

  static getBool(String key) async {
    SharedPreferences prefs = await initialize();
    return prefs.getBool(key);
  }

  static clearAll() async {
    SharedPreferences prefs = await initialize();
    prefs.clear();
  }
}
