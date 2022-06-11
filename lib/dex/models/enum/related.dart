import 'package:json_annotation/json_annotation.dart';

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
  @JsonValue('main_story')
  mainStory,

  /// 与这部漫画的故事同时发生的副业
  @JsonValue('side_story')
  sideStory,

  /// 这部衍生漫画的原著改编自
  @JsonValue('adapted_from')
  adaptedFrom,

  /// 基于这部漫画的官方衍生作品
  @JsonValue('spin_off')
  spinOff,

  /// 这部自助出版的衍生漫画是基于原著
  @JsonValue('based_on')
  basedOn,

  /// 斗金石 根据这部漫画自行出版的衍生作品
  @JsonValue('doujinshi')
  douJinShi,

  /// 这部漫画的知识产权和这部漫画一样
  @JsonValue('same_franchise')
  sameFranchise,

  /// 一部漫画发生在和这部漫画一样的虚构世界里
  @JsonValue('shared_universe')
  sharedUniverse,

  /// 这部漫画的另一个故事
  @JsonValue('alternate_story')
  alternateStory,

  /// 这部漫画的另一个版本没有其他特别的区别
  @JsonValue('alternate_version')
  alternateVersion,
}
