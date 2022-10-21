import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> setValueUnderString({
    required String key,
    dynamic value,
  }) async {
    final _prefs = await SharedPreferences.getInstance();
    try {
      return _prefs.setString(key, value);
    } on Exception catch (error) {
      throw Exception(
        'An error has occurred when setting data under key String: $key. $error',
      );
    }
  }

  static Future<String?> getValueUnderString(String key) async {
    try {
      return await _getString(key);
    } on Exception catch (error) {
      throw Exception(
        'An error has occurred when try to get data under key String: $key: $error',
      );
    }
  }

  static Future<bool?> deleteValueUnderString(String key) async {
    try {
      if ((await _getString(key)) != null) return await _deleteString(key);
      return false;
    } on Exception catch (error) {
      throw Exception(
        'An error has occurred when try to get data under key String: $key: $error',
      );
    }
  }

  static Future<String?> _getString(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key);
  }

  static Future<bool?> _deleteString(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.remove(key);
  }
}
