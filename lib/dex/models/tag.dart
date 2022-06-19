import 'package:json_annotation/json_annotation.dart';
import 'attributes/tag_attributes.dart';
import 'enum/entity_type.dart';
import 'enum/response_type.dart';
import 'relationship.dart';
import 'response.dart';

part 'tag.g.dart';

/// 标签列表 响应
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TagListResponse extends PageResponse<Tag> {
  TagListResponse({
    required super.response,
    required super.data,
    required super.limit,
    required super.offset,
    required super.total,
  });

  factory TagListResponse.fromJson(Map<String, dynamic> json) => _$TagListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TagListResponseToJson(this);
}

/// 标签 响应
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TagResponse extends OkResponse<Tag> {
  TagResponse({required super.response, required super.data});

  factory TagResponse.fromJson(Map<String, dynamic> json) => _$TagResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TagResponseToJson(this);
}

/// 标签
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Tag {
  /// 标签id
  final String id;

  /// 类型
  final EntityType type;

  /// 标签属性
  final TagAttributes attributes;

  /// 关系
  final List<Relationship> relationships;

  Tag({
    required this.id,
    required this.type,
    required this.attributes,
    required this.relationships,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
