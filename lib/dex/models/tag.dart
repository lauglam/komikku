import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/attributes/tag_attributes.dart';
import 'package:komikku/dex/models/enum/entity_type.dart';
import 'package:komikku/dex/models/enum/response_type.dart';
import 'package:komikku/dex/models/relationship.dart';
import 'package:komikku/dex/models/response.dart';

/// 标签列表 响应
class TagListResponse extends PageResponse<Tag> {
  TagListResponse({
    required super.response,
    required super.data,
    required super.limit,
    required super.offset,
    required super.total,
  });

  factory TagListResponse.fromJson(Map<String, dynamic> json) => TagListResponse(
        response: $enumDecode(responseTypeEnumMap, json['response']),
        data: (json['data'] as List<dynamic>)
            .map((e) => Tag.fromJson(e as Map<String, dynamic>))
            .toList(),
        limit: json['limit'] as int,
        offset: json['offset'] as int,
        total: json['total'] as int,
      );

  Map<String, dynamic> toJson() => {
        'response': responseTypeEnumMap[response],
        'data': data,
        'limit': limit,
        'offset': offset,
        'total': total,
      };
}

/// 标签 响应
class TagResponse extends OkResponse<Tag> {
  TagResponse({required super.response, required super.data});

  factory TagResponse.fromJson(Map<String, dynamic> json) => TagResponse(
        response: $enumDecode(responseTypeEnumMap, json['response']),
        data: Tag.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'response': entityTypeEnumMap[response],
        'data': data.toJson(),
      };
}

/// 标签
class Tag {
  final String id;
  final EntityType type;
  final TagAttributes attributes;
  final List<Relationship> relationships;

  Tag({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json['id'] as String,
        type: $enumDecode(entityTypeEnumMap, json['type']),
        attributes: TagAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
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
