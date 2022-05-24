import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _refreshExpire = Duration(days: 29);
const _sessionExpire = Duration(minutes: 14);

/// 是否登录
Future<bool> get isLogin async {
  return await session != null || await refresh != null;
}

/// 设置刷新令牌
Future<void> setRefresh(String token) async {
  var file = await _localFile;
  var jsonString = jsonEncode(Refresh(
    token: token,
    expire: DateTime.now().add(_refreshExpire),
  ));

  file.writeAsString(jsonString);
}

/// 设置会话令牌
Future<bool> setSession(String token) async {
  final prefs = await SharedPreferences.getInstance();
  var result = await prefs.setStringList('session', [
    DateTime.now().add(_sessionExpire).toIso8601String(),
    token,
  ]);

  return result;
}

/// 获取刷新令牌
Future<String?> get refresh async {
  var file = await _localFile;
  var jsonString = await file.readAsString();
  if (jsonString.isEmpty) return null;

  var refreshMap = jsonDecode(jsonString);
  // 过期返回null
  if (DateTime.now().isAfter(DateTime.parse(refreshMap['expire']))) {
    return null;
  }

  return refreshMap['token'];
}

/// 获取会话令牌
Future<String?> get session async {
  final prefs = await SharedPreferences.getInstance();
  final list = prefs.getStringList('session');
  if (list == null) return null;

  if (DateTime.now().isAfter(DateTime.parse(list[0]))) {
    await prefs.remove('session');
    return null;
  }

  return list[1];
}

/// 本地文件
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/refresh_token');
}

/// 应用目录
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

/// 刷新令牌
class Refresh {
  String token;
  DateTime expire;

  Refresh({
    required this.token,
    required this.expire,
  });

  factory Refresh.fromJson(Map<String, dynamic> json) => Refresh(
        token: json['token'] as String,
        expire: DateTime.parse(json['expire'] as String),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'expire': expire.toIso8601String(),
      };
}
