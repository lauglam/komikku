class History {
  /// 漫画id
  /// 后续更新同一漫画，只更改[chapterReadMarker]和[updatedAt]
  final String id;

  /// 图片
  final String imageUrl;

  /// 标题
  final String title;

  /// 状态
  String status;

  /// 最新卷
  String lastVolume;

  /// 最新章
  String lastChapter;

  /// 当前阅读章节id
  String chapterReadMarker;

  /// 更新时间
  /// 初次创建时[updatedAt]=[createdAt]
  DateTime updatedAt;

  /// 创建时间
  final DateTime createdAt;

  History({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.status,
    required this.lastVolume,
    required this.lastChapter,
    required this.chapterReadMarker,
    required this.updatedAt,
    required this.createdAt,
  });
}
