import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/enum/entity_type.dart';
import 'package:komikku/dex/models/enum/related.dart';

class Relationship {
  String id;
  EntityType type;
  Related? related;
  dynamic attributes;

  Relationship({
    required this.id,
    required this.type,
    this.related,
    this.attributes,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
        id: json['id'] as String,
        type: $enumDecode(entityTypeEnumMap, json['type']),
        related: $enumDecodeNullable(relatedEnumMap, json['related']),
        attributes: json['attributes'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': entityTypeEnumMap[type],
        'related': relatedEnumMap[related],
        'attributes': attributes,
      };
}
