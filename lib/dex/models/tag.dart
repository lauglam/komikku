import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/attributes/tag_attributes.dart';
import 'package:komikku/dex/models/enum/entity_type.dart';
import 'package:komikku/dex/models/relationship.dart';

/// 标签
class Tag {
  String id;
  EntityType type;
  TagAttributes attributes;
  List<Relationship> relationships;

  Tag({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json['id'] as String,
        type: $enumDecode(entityTypeEnumMap, json['type']),
        attributes:
            TagAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
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
