/// Hive数据库的名称
const mainBox = 'main';

/// Hive数据库中，刷新令牌的键
/// 有效时间29天
const refreshTokenKey = 'refresh_token';

/// Hive数据库中，会话令牌的键
/// 有效时间15分钟
const sessionTokenKey = 'session_token';

/// Hive数据库中，内容分级的键
/// ['safe', 'suggestive', 'erotica', 'pornographic']
const contentRatingKey = 'content_rating';

/// Hive数据库中，章节翻译语言的键
/// 默认：['zh', 'zh-hk']
const translatedLanguageKey = 'translated_language';

/// Hive数据库中，阅读页图片是否压缩的选项键
/// 默认：false 不压缩
const dataSaverKey = 'data_saver';

/// 默认图片压缩（不压缩）
const defaultDataSaver = false;

/// 默认内容分级
// const defaultContentRating = ['safe', 'suggestive', 'erotica', 'pornographic'];
const defaultContentRating = ['safe', 'suggestive', 'erotica'];

/// 默认过滤章节翻译语言
const defaultTranslatedLanguage = ['zh', 'zh-hk'];

/// MangaDex服务器地址
const serverUrl = 'https://api.mangadex.org';
