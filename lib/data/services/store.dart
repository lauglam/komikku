import 'package:hive_flutter/hive_flutter.dart';

import '../model/token.dart';

import 'base.dart';

class StoreService with HiveServiceMixin {
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

  factory StoreService() => _instance;

  static final StoreService _instance = StoreService._internal();

  StoreService._internal();

  /// Create and initialize the hive database.
  Future<void> initial() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TokenAdapter());

    await Hive.openBox(masterBox,
        compactionStrategy: (entries, deletedEntries) {
      return deletedEntries > 50;
    });
  }

  /// 判断是否登录
  bool get userLoginState => sessionToken != null || refreshToken != null;

  /// 获取会话令牌
  String? get sessionToken {
    final value = get(_sessionTokenKey);
    if (value != null && !_isExpire(value.expire)) {
      return value.value;
    }

    return null;
  }

  /// 获取刷新令牌
  String? get refreshToken {
    final value = get(_refreshTokenKey);
    if (value != null && !_isExpire(value.expire)) {
      return value.value;
    }

    return null;
  }

  /// 获取内容分级
  List<String> get contentRating {
    final value = get(_contentRatingKey);
    return value == null ? _defaultContentRating : List.castFrom(value);
  }

  /// 获取章节翻译
  List<String> get translatedLanguage {
    final value = get(_translatedLanguageKey);
    return value == null ? _defaultTranslatedLanguage : List.castFrom(value);
  }

  /// 获取图片是否压缩
  bool get dataSaver {
    final value = get(_dataSaverKey);
    return value ?? _defaultDataSaver;
  }

  /// 设置会话令牌
  set sessionToken(String? value) {
    if (value == null) return;
    put(_sessionTokenKey, Token(value: value, expire: _expireForSession));
  }

  /// 设置刷新令牌
  set refreshToken(String? value) {
    if (value == null) return;
    put(_refreshTokenKey, Token(value: value, expire: _expireForRefresh));
  }

  /// 设置内容分级
  set contentRating(List<String> value) {
    put(_contentRatingKey, value);
  }

  /// 设置章节翻译
  set translatedLanguage(List<String> value) {
    put(_translatedLanguageKey, value);
  }

  /// 设置图片是否压缩
  set dataSaver(bool value) {
    put(_dataSaverKey, value);
  }

  void removeSessionToken() {
    delete(_sessionTokenKey);
  }

  void removeRefreshToken() {
    delete(_refreshTokenKey);
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
