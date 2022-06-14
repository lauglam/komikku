import 'package:hive_flutter/hive_flutter.dart';

import 'model/token.dart';
import 'model/token_adapter.dart';

class HiveDatabase {
  /// Hive数据库的名称
  static const _mainBox = 'main';

  /// Hive数据库中，刷新令牌的键  /// 有效时间29天
  static const _refreshTokenKey = 'refresh_token';

  /// Hive数据库中，会话令牌的键
  /// 有效时间15分钟
  static const _sessionTokenKey = 'session_token';

  /// Hive数据库中，内容分级的键
  /// ['safe', 'suggestive', 'erotica', 'pornographic']
  static const _contentRatingKey = 'content_rating';

  /// Hive数据库中，章节翻译语言的键
  /// 默认：['zh', 'zh-hk']
  static const _translatedLanguageKey = 'translated_language';

  /// Hive数据库中，阅读页图片是否压缩的选项键
  /// 默认：false 不压缩
  static const _dataSaverKey = 'data_saver';

  /// 默认图片压缩（不压缩）
  static const _defaultDataSaver = false;

  /// 默认内容分级
  // static const _defaultContentRating = ['safe', 'suggestive', 'erotica', 'pornographic'];
  static const _defaultContentRating = ['safe', 'suggestive', 'erotica'];

  /// 默认过滤章节翻译语言
  static const _defaultTranslatedLanguage = ['zh', 'zh-hk'];

  /// 初始化Hive数据库
  static Future<void> initial() async {
    // 初始化(负责数据库的位置和新建等)
    await Hive.initFlutter();

    // 注册适配器
    Hive.registerAdapter(TokenAdapter());

    // 打开数据库
    await Hive.openBox(_mainBox, compactionStrategy: (entries, deletedEntries) {
      // 当50个键被覆盖或删除时，compactionStrategy将压缩空间
      return deletedEntries > 50;
    });
  }

  /// 判断是否登录
  static bool get userLoginState => sessionToken != null || refreshToken != null;

  /// 获取会话令牌
  static String? get sessionToken {
    final value = _get(_sessionTokenKey);
    if (value != null && !_isExpire(value.expire)) {
      return value.value;
    }

    return null;
  }

  /// 获取刷新令牌
  static String? get refreshToken {
    final value = _get(_refreshTokenKey);
    if (value != null && !_isExpire(value.expire)) {
      return value.value;
    }

    return null;
  }

  /// 获取内容分级
  static List<String> get contentRating {
    final value = _get(_contentRatingKey);
    return value == null ? _defaultContentRating : List.castFrom(value);
  }

  /// 获取章节翻译
  static List<String> get translatedLanguage {
    final value = _get(_translatedLanguageKey);
    return value == null ? _defaultTranslatedLanguage : List.castFrom(value);
  }

  /// 获取图片是否压缩
  static bool get dataSaver {
    final value = _get(_dataSaverKey);
    return value ?? _defaultDataSaver;
  }

  /// 设置会话令牌
  static set sessionToken(String? value) {
    if (value == null) return;
    _put(_sessionTokenKey, Token(value: value, expire: _expireForSession));
  }

  /// 设置刷新令牌
  static set refreshToken(String? value) {
    if (value == null) return;
    _put(_refreshTokenKey, Token(value: value, expire: _expireForRefresh));
  }

  /// 设置内容分级
  static set contentRating(List<String> value) {
    _put(_contentRatingKey, value);
  }

  /// 设置章节翻译
  static set translatedLanguage(List<String> value) {
    _put(_translatedLanguageKey, value);
  }

  /// 设置图片是否压缩
  static set dataSaver(bool value) {
    _put(_dataSaverKey, value);
  }

  static void removeSessionToken() {
    final box = Hive.box(_mainBox);
    box.delete(_sessionTokenKey);
  }

  static void removeRefreshToken() {
    final box = Hive.box(_mainBox);
    box.delete(_refreshTokenKey);
  }

  static dynamic _get(dynamic key) {
    final box = Hive.box(_mainBox);
    return box.get(key);
  }

  static Future<void> _put(dynamic key, dynamic value) async {
    final box = Hive.box(_mainBox);
    await box.put(key, value);
  }

  /// 会话令牌的过期时间
  static DateTime get _expireForSession {
    return DateTime.now().add(const Duration(minutes: 14));
  }

  /// 刷新令牌的过期时间
  static DateTime get _expireForRefresh {
    return DateTime.now().add(const Duration(days: 29));
  }

  /// 是否过期
  static bool _isExpire(DateTime date) {
    return DateTime.now().isAfter(date);
  }
}
