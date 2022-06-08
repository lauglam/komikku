import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  /// 会话令牌key
  static const _sessionKey = 'session';

  /// 刷新令牌key
  static const _refreshKey = 'refresh';

  /// 图片质量key
  static const _dataSaverKey = 'data_saver';

  /// 内容分级key
  static const _contentRatingKey = 'content_rating';

  /// 过滤章节翻译语言key
  static const _translatedLanguageKey = 'translated_language';

  /// 15分钟过期
  static const _sessionExpire = Duration(minutes: 14);

  /// 30天过期
  static const _refreshExpire = Duration(days: 29);

  /// 默认图片压缩（不压缩）
  static const _defaultDataSaver = false;

  /// 默认内容分级
  static const _defaultContentRating = ['safe', 'suggestive', 'erotica', 'pornographic'];

  /// 默认过滤章节翻译语言
  static const _defaultTranslatedLanguage = ['zh', 'zh-hk'];

  /// 用户状态
  static Future<bool> get userLoginState async {
    return await session != null || await refresh != null;
  }

  /// 获取会话令牌
  static Future<String?> get session async {
    final list = await _getStringList(_sessionKey);
    if (list == null) return null;

    if (_isExpire(list[0])) {
      await _remove(_sessionKey);
      return null;
    }

    return list[1];
  }

  /// 获取刷新令牌
  static Future<String?> get refresh async {
    final list = await _getStringList(_refreshKey);
    if (list == null) return null;

    if (_isExpire(list[0])) {
      await _remove(_refreshKey);
      return null;
    }

    return list[1];
  }

  /// 获取图片质量设置
  static Future<bool> get dataSaver async {
    final boolean = await _getBool(_dataSaverKey);
    return boolean ?? _defaultDataSaver;
  }

  /// 获取内容分级设置
  static Future<List<String>> get contentRating async {
    final list = await _getStringList(_contentRatingKey);
    return list ?? _defaultContentRating;
  }

  /// 获取章节翻译语言设置
  static Future<List<String>> get translatedLanguage async {
    final list = await _getStringList(_translatedLanguageKey);
    return list ?? _defaultTranslatedLanguage;
  }

  /// 设置会话令牌
  static Future<bool> setSession(String token) async {
    final prefs = await SharedPreferences.getInstance();

    final expire = DateTime.now().add(_sessionExpire).toIso8601String();
    return await prefs.setStringList(_sessionKey, [expire, token]);
  }

  /// 设置刷新令牌
  static Future<void> setRefresh(String token) async {
    final expire = DateTime.now().add(_refreshExpire).toIso8601String();
    await _setStringList(_refreshKey, [expire, token]);
  }

  /// 设置图片压缩
  static Future<void> setDataSaver(bool value) async => await _setBool(_dataSaverKey, value);

  /// 设置内容分级
  static Future<void> setContentRating(List<String> value) async =>
      await _setStringList(_contentRatingKey, value);

  /// 设置章节翻译语言
  static Future<void> setTranslatedLanguage(List<String> value) async =>
      await _setStringList(_translatedLanguageKey, value);

  /// 移除会话令牌
  static Future<void> removeSession() async => await _remove(_sessionKey);

  /// 移除刷新令牌
  static Future<void> removeRefresh() async => await _remove(_refreshKey);

  static Future<List<String>?> _getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  static Future<String?> _getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<bool?> _getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<bool> _setStringList(String key, List<String> value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }

  static Future<bool> _setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> _setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool> _remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static bool _isExpire(String dateString) {
    return DateTime.now().isAfter(DateTime.parse(dateString));
  }
}
