import 'package:json_annotation/json_annotation.dart';
import 'chapter.dart';
import 'enum/response_type.dart';
import 'response.dart';

part 'chapter_list.g.dart';

/// 章节列表响应
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChapterListResponse extends PageResponse<Chapter> {
  ChapterListResponse({
    required super.response,
    required super.data,
    required super.limit,
    required super.offset,
    required super.total,
  });

  factory ChapterListResponse.fromJson(Map<String, dynamic> json) =>
      _$ChapterListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterListResponseToJson(this);
}
