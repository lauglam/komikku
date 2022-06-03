import 'package:komikku/dex/models/localized_string.dart';

/// 标签属性
class TagAttributes {
  final LocalizedString name;
  final String group;
  final int version;
  final LocalizedString? description;

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
                : LocalizedString.fromJson(json['description'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    val['name'] = name;
    val['group'] = group;
    val['version'] = version;
    writeNotNull('description', description?.toJson());
    return val;
  }
}
