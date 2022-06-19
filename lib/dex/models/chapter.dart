import 'package:json_annotation/json_annotation.dart';
import 'attributes/chapter_attributes.dart';
import 'enum/entity_type.dart';
import 'enum/response_type.dart';
import 'relationship.dart';
import 'response.dart';

part 'chapter.g.dart';

/// 章节响应
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChapterResponse extends OkResponse<Chapter> {
  ChapterResponse({required super.response, required super.data});

  factory ChapterResponse.fromJson(Map<String, dynamic> json) => _$ChapterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterResponseToJson(this);
}

/// 章节
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Chapter {
  final String id;
  final EntityType type;
  final ChapterAttributes attributes;
  final List<Relationship> relationships;

  Chapter({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}
