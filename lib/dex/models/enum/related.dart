enum Related {
  /// 这部漫画的单色变体
  monochrome,

  /// 这部漫画的彩色变体
  colored,

  /// 这部漫画在正式连载之前的原版
  preserialization,

  /// 这部漫画的正式连载
  serialization,

  /// 同一系列中的上一个条目
  prequel,

  /// 同一系列的下一个条目
  sequel,

  /// 这部漫画的是基于原始叙事
  mainStory,

  /// 与这部漫画的故事同时发生的副业
  sideStory,

  /// 这部衍生漫画的原著改编自
  adaptedFrom,

  /// 基于这部漫画的官方衍生作品
  spinOff,

  /// 这部自助出版的衍生漫画是基于原著
  basedOn,

  /// 斗金石 根据这部漫画自行出版的衍生作品
  douJinShi,

  /// 这部漫画的知识产权和这部漫画一样
  sameFranchise,

  /// 一部漫画发生在和这部漫画一样的虚构世界里
  sharedUniverse,

  /// 这部漫画的另一个故事
  alternateStory,

  /// 这部漫画的另一个版本没有其他特别的区别
  alternateVersion,
}

const relatedEnumMap = {
  Related.monochrome: 'monochrome',
  Related.colored: 'colored',
  Related.preserialization: 'preserialization',
  Related.serialization: 'serialization',
  Related.prequel: 'prequel',
  Related.sequel: 'sequel',
  Related.mainStory: 'main_story',
  Related.sideStory: 'side_story',
  Related.adaptedFrom: 'adapted_from',
  Related.spinOff: 'spin_off',
  Related.basedOn: 'based_on',
  Related.douJinShi: 'doujinshi',
  Related.sameFranchise: 'same_franchise',
  Related.sharedUniverse: 'shared_universe',
  Related.alternateStory: 'alternate_story',
  Related.alternateVersion: 'alternate_version',
};
