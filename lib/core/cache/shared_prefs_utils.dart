import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsUtils {
  static late SharedPreferences _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({required String key, required dynamic value}) {
    if (value is int) {
      return _prefs.setInt(key, value);
    } else if (value is bool) {
      return _prefs.setBool(key, value);
    } else if (value is double) {
      return _prefs.setDouble(key, value);
    } else if (value is String) {
      return _prefs.setString(key, value);
    } else {
      return _prefs.setStringList(key, value);
    }
  }

  static Object? getData({required String key}) {
    return _prefs.get(key);
  }

  static Future<bool> removeData({required String key}) async{
    return await _prefs.remove(key);
  }
}
