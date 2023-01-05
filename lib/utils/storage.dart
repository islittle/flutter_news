import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储
class Storage {
  static final Storage _instance = Storage._();
  factory Storage() => _instance;
  static SharedPreferences? _prefs;

  Storage._();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// 设置 json 对象
  Future<bool> setJSON(String key, dynamic jsonVal) async {
    String jsonString = jsonEncode(jsonVal);
    return await _prefs!.setString(key, jsonString);
  }

  /// 获取 json 对象
  dynamic getJSON(String key) {
    String? jsonString = _prefs!.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool> setBool(String key, bool val) async {
    return await _prefs!.setBool(key, val);
  }

  bool getBool(String key) {
    bool? val = _prefs!.getBool(key);
    return val ?? false;
  }

  Future<bool> remove(String key) async {
    return await _prefs!.remove(key);
  }
}
