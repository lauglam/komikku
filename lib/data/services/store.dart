import 'package:hive_flutter/hive_flutter.dart';

import '../model/token.dart';

import 'base.dart';

class StoreService with HiveServiceMixin {
  /// The key of refresh token.
  /// Expire time: 30days.
  static const _refreshTokenKey = 'refresh_token';

  /// The key of session token.
  /// Expire time: 15min.
  static const _sessionTokenKey = 'session_token';

  /// The key of content rating.
  /// ['safe', 'suggestive', 'erotica', 'pornographic']
  static const _contentRatingKey = 'content_rating';

  /// The key of translated language.
  /// default: ['zh', 'zh-hk'].
  static const _translatedLanguageKey = 'translated_language';

  /// The key of data saver.
  static const _dataSaverKey = 'data_saver';

  /// The default value of data saver.
  static const _defaultDataSaver = false;

  /// The default value of content rating.
  // static const _defaultContentRating = ['safe', 'suggestive', 'erotica', 'pornographic'];
  static const _defaultContentRating = ['safe', 'suggestive', 'erotica'];

  /// The default value of translated language.
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

  /// Whether the user login state.
  bool get loginStatus => sessionToken != null || refreshToken != null;

  /// Get session token.
  /// Expire time: 15min.
  String? get sessionToken {
    final value = get(_sessionTokenKey);
    if (value != null && !_isExpire(value.expire)) {
      return value.value;
    }

    return null;
  }

  /// Get refresh token.
  /// Expire time: 30days.
  String? get refreshToken {
    final value = get(_refreshTokenKey);
    if (value != null && !_isExpire(value.expire)) {
      return value.value;
    }

    return null;
  }

  /// Get content rating.
  List<String> get contentRating {
    final value = get(_contentRatingKey);
    return value == null ? _defaultContentRating : List.castFrom(value);
  }

  /// Get translated language.
  List<String> get translatedLanguage {
    final value = get(_translatedLanguageKey);
    return value == null ? _defaultTranslatedLanguage : List.castFrom(value);
  }

  /// Get whether the reader image data saver.
  bool get dataSaver {
    final value = get(_dataSaverKey);
    return value ?? _defaultDataSaver;
  }

  /// Set session token.
  /// If [value] is null, delete the value.
  set sessionToken(String? value) {
    if (value == null) {
      delete(_sessionTokenKey);
      return;
    }
    put(_sessionTokenKey, Token(value: value, expire: _expireForSession));
  }

  /// Set refresh token.
  /// If [value] is null, delete the value.
  set refreshToken(String? value) {
    if (value == null) {
      delete(_refreshTokenKey);
      return;
    }
    put(_refreshTokenKey, Token(value: value, expire: _expireForRefresh));
  }

  /// Set content rating.
  set contentRating(List<String> value) {
    put(_contentRatingKey, value);
  }

  /// Set translated language.
  set translatedLanguage(List<String> value) {
    put(_translatedLanguageKey, value);
  }

  /// Set whether the reader image data saver.
  set dataSaver(bool value) {
    put(_dataSaverKey, value);
  }

  /// The expire time of session token.
  static DateTime get _expireForSession {
    return DateTime.now().add(const Duration(minutes: 14));
  }

  /// The expire time of refresh token.
  static DateTime get _expireForRefresh {
    return DateTime.now().add(const Duration(days: 29));
  }

  /// Whether the time is after input.
  static bool _isExpire(DateTime date) {
    return DateTime.now().isAfter(date);
  }
}
