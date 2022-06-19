import 'package:json_annotation/json_annotation.dart';
import 'enum/entity_type.dart';
import 'enum/related.dart';
import 'package:collection/collection.dart';

part 'relationship.g.dart';

/// Relationship.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Relationship {
  /// The id of relationship.
  final String id;

  /// The type of relationship.
  final EntityType type;

  /// The related of relationship.
  final Related? related;

  /// The attribute of relationship.
  final dynamic attributes;

  Relationship({
    required this.id,
    required this.type,
    this.related,
    this.attributes,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => _$RelationshipFromJson(json);

  Map<String, dynamic> toJson() => _$RelationshipToJson(this);
}

extension RelationshipsExtensions on List<Relationship> {
  /// Return a [Relationship] which EntityType is [type].
  Relationship firstType(EntityType type) {
    return firstWhere((relationship) => relationship.type == type);
  }

  /// Return a [Relationship] which EntityType is [type].
  /// Return null if not exists.
  Relationship? firstTypeOrDefault(EntityType type) {
    return firstWhereOrNull((relationship) => relationship.type == type);
  }
}
