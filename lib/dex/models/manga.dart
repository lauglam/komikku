import 'package:json_annotation/json_annotation.dart';
import 'attributes/manga_attributes.dart';
import 'enum/entity_type.dart';
import 'relationship.dart';

part 'manga.g.dart';

/// Manga
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Manga {
  /// The id of manga.
  final String id;

  /// The type of manga.
  final EntityType type;

  /// The attributes of manga.
  final MangaAttributes attributes;

  /// The relationship of manga.
  final List<Relationship> relationships;

  Manga({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);

  Map<String, dynamic> toJson() => _$MangaToJson(this);
}
