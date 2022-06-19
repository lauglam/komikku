import 'package:json_annotation/json_annotation.dart';
import 'enum/result.dart';
import 'response.dart';

part 'chapter_read_marker.g.dart';

/// The read marker response of manga.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChapterReadMarkerResponse extends Response {
  ChapterReadMarkerResponse({required super.result, required this.data});

  /// The chapter id list of read.
  final List<String> data;

  factory ChapterReadMarkerResponse.fromJson(Map<String, dynamic> json) =>
      _$ChapterReadMarkerResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChapterReadMarkerResponseToJson(this);
}

/// 分组漫画阅读记录响应
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class GroupedChapterReadMarkerResponse extends Response {
  GroupedChapterReadMarkerResponse({required super.result, required this.data});

  /// 漫画id和阅读过的章节id列表
  final Map<String, List<String>> data;

  factory GroupedChapterReadMarkerResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupedChapterReadMarkerResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GroupedChapterReadMarkerResponseToJson(this);
}

/// 批量上传阅读记录
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChapterReadMarkerBatch {
  /// 要标记为已阅读的章节id
  final List<String>? chapterIdsRead;

  /// 要标记为未阅读的章节id
  final List<String>? chapterIdsUnread;

  ChapterReadMarkerBatch({this.chapterIdsRead, this.chapterIdsUnread});

  factory ChapterReadMarkerBatch.fromJson(Map<String, dynamic> json) =>
      _$ChapterReadMarkerBatchFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterReadMarkerBatchToJson(this);
}
