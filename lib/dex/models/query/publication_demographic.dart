/// 出版物人口统计
enum PublicationDemographic {
  /// 少年
  shounen,

  /// 少女
  shoujo,

  /// 女士
  josei,

  /// 青年
  seinen,
}

const publicationDemographicEnumMap = {
  PublicationDemographic.shounen: 'shounen',
  PublicationDemographic.shoujo: 'shoujo',
  PublicationDemographic.josei: 'josei',
  PublicationDemographic.seinen: 'seinen',
};
