import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/enum/entity_type.dart';
import 'package:komikku/dex/models/enum/related.dart';
import 'package:collection/collection.dart';

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

extension RelationshipsExtensions on List<Relationship> {
  /// 返回一个 EntityType 为输入值的 Relationship
  Relationship firstType(EntityType type) {
    return firstWhere((relationship) => relationship.type == type);
  }

  /// 返回一个 EntityType 为输入值的 Relationship（未找到时返回 null）
  Relationship? firstTypeOrDefault(EntityType type) {
    return firstWhereOrNull((relationship) => relationship.type == type);
  }
}
