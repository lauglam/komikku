enum EntityType {
  /// 漫画
  manga,

  /// 标签
  tag,

  /// 漫画的封面
  coverArt,

  /// 章节
  chapter,

  /// 扫描组
  scanlationGroup,

  /// 用户
  user,

  /// 自定义列表
  customList,

  /// 作者
  author,

  /// 艺术家
  artist,

  /// 映射
  mappingId,

  /// 漫画关系
  mangaRelation,

  /// 上传会话
  uploadSession,

  /// 上传文件会话
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
