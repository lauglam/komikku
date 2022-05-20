import 'package:json_annotation/json_annotation.dart';

enum EntityType {
  /// 漫画
  manga,

  /// 标签
  tag,

  /// 漫画的封面
  @JsonValue('cover_art')
  coverArt,

  /// 章节
  chapter,

  /// 扫描组
  @JsonValue('scanlation_group')
  scanlationGroup,

  /// 用户
  user,

  /// 自定义列表
  @JsonValue('custom_list')
  customList,

  /// 作者
  author,

  /// 艺术家
  artist,

  /// 映射
  @JsonValue('mapping_id')
  mappingId,

  /// 漫画关系
  @JsonValue('manga_relation')
  mangaRelation,

  /// 上传会话
  @JsonValue('upload_session')
  uploadSession,

  /// 上传文件会话
  @JsonValue('upload_session_file')
  uploadSessionFile,

  ///报告
  report,
}

const entityTypeEnumMap = {
  EntityType.manga: 'manga',
  EntityType.tag: 'tag',
  EntityType.coverArt: 'cover_art',
  EntityType.chapter: 'chapter',
  EntityType.scanlationGroup: 'scanlation_group',
  EntityType.user: 'user',
  EntityType.customList: 'custom_list',
  EntityType.author: 'author',
  EntityType.artist: 'artist',
  EntityType.mappingId: 'mapping_id',
  EntityType.mangaRelation: 'manga_relation',
  EntityType.uploadSession: 'upload_session',
  EntityType.uploadSessionFile: 'upload_session_file',
  EntityType.report: 'report',
};
