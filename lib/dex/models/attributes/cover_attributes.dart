import 'package:json_annotation/json_annotation.dart';

part 'cover_attributes.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class CoverAttributes {
  /// The file name of this cover.
  final String fileName;

  /// The volume belong to.
  /// nullable.
  final String? volume;

  /// The description of this chapter.
  /// nullable.
  final String? description;

  /// The local language of this chapter.
  /// nullable.
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
