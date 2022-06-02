import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/attributes/manga_attributes.dart';
import 'package:komikku/dex/models/enum/entity_type.dart';
import 'package:komikku/dex/models/relationship.dart';

class Manga {
  String id;
  EntityType type;
  MangaAttributes attributes;
  List<Relationship> relationships;

  Manga({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Manga.fromJson(Map<String, dynamic> json) => Manga(
        id: json['id'] as String,
        type: $enumDecode(entityTypeEnumMap, json['type']),
        attributes: MangaAttributes.fromJson(
            json['attributes'] as Map<String, dynamic>),
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
