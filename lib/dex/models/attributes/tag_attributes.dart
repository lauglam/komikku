import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/localized_string.dart';

part 'tag_attributes.g.dart';

/// 标签属性
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TagAttributes {
  /// 标签名称
  final LocalizedString name;

  /// 所属标签组
  final String group;

  /// 版本
  final int version;

  /// 描述
  @JsonKey(readValue: readSingleOrArray)
  final LocalizedString? description;

  TagAttributes({
    required this.name,
    required this.group,
    required this.version,
    this.description,
  });

  factory TagAttributes.fromJson(Map<String, dynamic> json) => _$TagAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$TagAttributesToJson(this);
}
