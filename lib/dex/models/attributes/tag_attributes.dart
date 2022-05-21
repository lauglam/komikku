import 'package:komikku/dex/models/localized_string.dart';

/// 标签属性
class TagAttributes {
  LocalizedString name;
  String group;
  int version;
  LocalizedString? description;

  TagAttributes({
    required this.name,
    required this.group,
    required this.version,
    this.description,
  });

  factory TagAttributes.fromJson(Map<String, dynamic> json) => TagAttributes(
        name: LocalizedString.fromJson(json['name'] as Map<String, dynamic>),
        group: json['group'] as String,
        version: json['version'] as int,
        description: json['description'] == null
            ? null
            : json['description'] is Iterable
                ? null
                : LocalizedString.fromJson(
                    json['description'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'group': group,
        'version': version,
        'description': description,
      };
}
