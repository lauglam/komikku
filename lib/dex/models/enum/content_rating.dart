/// 分级
enum ContentRating {
  /// 安全
  safe,

  /// 性暗示
  suggestive,

  /// 涉黄
  erotica,

  /// 色情
  pornographic,
}

const contentRatingEnumMap = {
  ContentRating.safe: 'safe',
  ContentRating.suggestive: 'suggestive',
  ContentRating.erotica: 'erotica',
  ContentRating.pornographic: 'pornographic',
};
