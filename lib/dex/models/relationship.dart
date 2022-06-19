import 'package:json_annotation/json_annotation.dart';
import 'enum/entity_type.dart';
import 'enum/related.dart';
import 'package:collection/collection.dart';

part 'relationship.g.dart';

/// 关系
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Relationship {
  /// 关系id
  final String id;

  /// 类型
  final EntityType type;

  /// 关系
  final Related? related;

  /// 属性
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
  /// 返回一个 EntityType 为输入值的 Relationship
  Relationship firstType(EntityType type) {
    return firstWhere((relationship) => relationship.type == type);
  }

  /// 返回一个 EntityType 为输入值的 Relationship（未找到时返回 null）
  Relationship? firstTypeOrDefault(EntityType type) {
    return firstWhereOrNull((relationship) => relationship.type == type);
  }
}
