import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/attributes/chapter_attributes.dart';
import 'package:komikku/dex/models/enum/entity_type.dart';
import 'package:komikku/dex/models/enum/response_type.dart';
import 'package:komikku/dex/models/relationship.dart';
import 'package:komikku/dex/models/response.dart';

/// 章节响应
class ChapterResponse extends OkResponse<Chapter> {
  ChapterResponse({required super.response, required super.data});

  factory ChapterResponse.fromJson(Map<String, dynamic> json) => ChapterResponse(
        response: $enumDecode(responseTypeEnumMap, json['response']),
        data: Chapter.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'response': entityTypeEnumMap[response],
        'data': data.toJson(),
      };
}

/// 章节
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

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json['id'] as String,
        type: $enumDecode(entityTypeEnumMap, json['type']),
        attributes: ChapterAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
        relationships: (json['relationships'] as List<dynamic>)
            .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': entityTypeEnumMap[type],
        'attributes': attributes.toJson(),
        'relationships': relationships.map((e) => e.toJson()).toList(),
      };
}
