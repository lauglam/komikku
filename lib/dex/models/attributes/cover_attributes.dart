import 'package:json_annotation/json_annotation.dart';

part 'cover_attributes.g.dart';

/// 封面属性
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CoverAttributes {
  /// 文件名
  final String fileName;

  /// 所属卷
  final String? volume;

  /// 描述
  final String? description;

  /// 语言环境
  final String? locale;

  CoverAttributes({
    required this.fileName,
    this.volume,
    this.description,
    this.locale,
  });

  factory CoverAttributes.fromJson(Map<String, dynamic> json) => _$CoverAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$CoverAttributesToJson(this);
}
