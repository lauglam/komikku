// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagAttributes _$TagAttributesFromJson(Map<String, dynamic> json) =>
    TagAttributes(
      name: LocalizedString.fromJson(json['name'] as Map<String, dynamic>),
      group: json['group'] as String,
      version: json['version'] as int,
      description: readSingleOrArray(json, 'description') == null
          ? null
          : LocalizedString.fromJson(
              readSingleOrArray(json, 'description') as Map<String, dynamic>),
    );

Map<String, dynamic> _$TagAttributesToJson(TagAttributes instance) {
  final val = <String, dynamic>{
    'name': instance.name.toJson(),
    'group': instance.group,
    'version': instance.version,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description?.toJson());
  return val;
}
