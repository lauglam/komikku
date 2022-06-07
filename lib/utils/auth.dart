import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  /// 用户状态
  static Future<bool> get userLoginState async {
    return await session != null || await refresh != null;
  }

  /// 获取会话令牌
  static Future<String?> get session async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('session');
    if (list == null) return null;

    if (DateTime.now().isAfter(DateTime.parse(list[0]))) {
      await prefs.remove('session');
      return null;
    }

    return list[1];
  }

  /// 设置会话令牌
  static Future<bool> setSession(String token) async {
    final prefs = await SharedPreferences.getInstance();

    var expire = DateTime.now().add(const Duration(minutes: 14)).toIso8601String();
    return await prefs.setStringList('session', [expire, token]);
  }

  /// 移除会话令牌
  static Future<void> removeSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session');
  }

  /// 获取刷新令牌
  static Future<String?> get refresh async {
    var file = await _file;
    if (!await file.exists()) return null;

    var refreshMap = json.decode(await file.readAsString());
    // 过期返回null
    if (DateTime.now().isAfter(DateTime.parse(refreshMap['expire']))) {
      return null;
    }

    return refreshMap['token'];
  }

  /// 设置刷新令牌
  static Future<void> setRefresh(String token) async {
    var file = await _file;
    var expire = DateTime.now().add(const Duration(days: 29)).toIso8601String();
    await file.writeAsString(json.encode({'token': token, 'expire': expire}));
  }

  /// 移除会话令牌
  static Future<void> removeRefresh() async {
    var file = await _file;
    if (await file.exists()) await file.delete();
  }

  /// 获取 .token 文件
  static Future<File> get _file async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/.token');
  }
}
