import 'package:json_annotation/json_annotation.dart';
import '../localized_string.dart';

part 'tag_attributes.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class TagAttributes {
  /// The name of this tag.
  final LocalizedString name;

  /// The group this tag belong to.
  final String group;

  /// The vision of this attributes.
  final int version;

  /// The description of this tag.
  /// nullable.
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
