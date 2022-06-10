import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:komikku/entities/token.dart';
import 'package:komikku/entities/token_adapter.dart';
import 'package:komikku/utils/app_settings.dart';

/// 初始化Hive数据库
Future<void> hiveInit() async {
  // 初始化(负责数据库的位置和新建等)
  await Hive.initFlutter();

  // 注册适配器
  Hive.registerAdapter(TokenAdapter());

  // 打开数据库
  await Hive.openBox(mainBox, compactionStrategy: (entries, deletedEntries) {
    // 当50个键被覆盖或删除时，compactionStrategy将压缩空间
    return deletedEntries > 50;
  });
}

/// 判断是否登录
bool get userLoginState => sessionToken != null || refreshToken != null;

/// 获取会话令牌
String? get sessionToken {
  final box = Hive.box(mainBox);
  final session = box.get(sessionTokenKey);
  if (session != null && !_isExpire(session.expire)) {
    return session.value;
  }

  return null;
}

/// 获取刷新令牌
String? get refreshToken {
  final box = Hive.box(mainBox);
  final refresh = box.get(refreshTokenKey);
  if (refresh != null && !_isExpire(refresh.expire)) {
    return refresh.value;
  }

  return null;
}

/// 获取内容分级
List<String> get contentRating {
  final box = Hive.box(mainBox);
  final contentRating = box.get(contentRatingKey);
  return contentRating == null ? defaultContentRating : List.castFrom(contentRating);
}

/// 获取章节翻译
List<String> get translatedLanguage {
  final box = Hive.box(mainBox);
  final translatedLanguage = box.get(translatedLanguageKey);
  return translatedLanguage == null ? defaultTranslatedLanguage : List.castFrom(translatedLanguage);
}

/// 获取图片是否压缩
bool get dataSaver {
  final box = Hive.box(mainBox);
  final dataSaver = box.get(dataSaverKey);
  return dataSaver ?? defaultDataSaver;
}

/// 设置会话令牌
set sessionToken(String? value) {
  if (value == null) return;
  final box = Hive.box(mainBox);
  box.put(sessionTokenKey, Token(value: value, expire: _expireForSession));
}

/// 设置刷新令牌
set refreshToken(String? value) {
  if (value == null) return;
  final box = Hive.box(mainBox);
  box.put(refreshTokenKey, Token(value: value, expire: _expireForRefresh));
}

/// 设置内容分级
set contentRating(List<String> value) {
  final box = Hive.box(mainBox);
  box.put(contentRatingKey, value);
}

/// 设置章节翻译
set translatedLanguage(List<String> value) {
  final box = Hive.box(mainBox);
  box.put(translatedLanguageKey, value);
}

/// 设置图片是否压缩
set dataSaver(bool value) {
  final box = Hive.box(mainBox);
  box.put(dataSaverKey, value);
}

void removeSessionToken() {
  final box = Hive.box(mainBox);
  box.delete(sessionTokenKey);
}

void removeRefreshToken() {
  final box = Hive.box(mainBox);
  box.delete(refreshTokenKey);
}

/// 会话令牌的过期时间
DateTime get _expireForSession {
  return DateTime.now().add(const Duration(minutes: 14));
}

/// 刷新令牌的过期时间
DateTime get _expireForRefresh {
  return DateTime.now().add(const Duration(days: 29));
}

/// 是否过期
bool _isExpire(DateTime date) {
  return DateTime.now().isAfter(date);
}
