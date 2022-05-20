import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/attributes/chapter_attributes.dart';
import 'package:komikku/dex/models/enum/entity_type.dart';
import 'package:komikku/dex/models/relationship.dart';
import 'package:komikku/dex/models/response.dart';

/// 章节响应
typedef ChapterResponse = SuccessResponse<Chapter>;

/// 章节
class Chapter {
  String id;
  EntityType type;
  ChapterAttributes attributes;
  List<Relationship> relationships;

  Chapter({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json['id'] as String,
        type: $enumDecode(entityTypeEnumMap, json['type']),
        attributes: ChapterAttributes.fromJson(
            json['attributes'] as Map<String, dynamic>),
        relationships: (json['relationships'] as List<dynamic>)
            .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': entityTypeEnumMap[type],
        'attributes': attributes,
        'relationships': relationships,
      };
}


