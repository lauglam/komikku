import 'package:json_annotation/json_annotation.dart';
import 'attributes/manga_attributes.dart';
import 'enum/entity_type.dart';
import 'relationship.dart';

part 'manga.g.dart';

/// 漫画
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Manga {
  /// 漫画id
  final String id;

  /// 类型
  final EntityType type;

  /// 漫画属性
  final MangaAttributes attributes;

  /// 关系
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
