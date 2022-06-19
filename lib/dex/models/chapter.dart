import 'package:json_annotation/json_annotation.dart';
import 'attributes/chapter_attributes.dart';
import 'enum/entity_type.dart';
import 'enum/response_type.dart';
import 'relationship.dart';
import 'response.dart';

part 'chapter.g.dart';

/// Chapter response.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChapterResponse extends OkResponse<Chapter> {
  ChapterResponse({required super.response, required super.data});

  factory ChapterResponse.fromJson(Map<String, dynamic> json) => _$ChapterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterResponseToJson(this);
}

/// Chapter
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Chapter {
  /// The id of chapter.
  final String id;

  /// The type of chapter.
  final EntityType type;

  /// The attributes of chapter.
  final ChapterAttributes attributes;

  /// The relationship of chapter.
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
