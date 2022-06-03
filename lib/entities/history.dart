class History {
  /// 主键id
  final String id;

  /// 漫画id
  /// 后续更新同一漫画，只更改[chapterId]和[updatedAt]
  final String mangaId;

  /// 章节id
  String chapterId;

  /// 更新时间
  /// 初次创建时[updatedAt]=[createdAt]
  DateTime updatedAt;

  /// 创建时间
  final DateTime createdAt;

  History({
    required this.id,
    required this.mangaId,
    required this.chapterId,
    required this.updatedAt,
    required this.createdAt,
  });
}
