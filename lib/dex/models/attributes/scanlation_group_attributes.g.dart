// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanlation_group_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScanlationGroupAttributes _$ScanlationGroupAttributesFromJson(
        Map<String, dynamic> json) =>
    ScanlationGroupAttributes(
      name: json['name'] as String,
      locked: json['locked'] as bool,
      official: json['official'] as bool,
      inactive: json['inactive'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: json['version'] as int,
      publishDelay: json['publishDelay'] as String?,
      altNames: (json['altNames'] as List<dynamic>?)
          ?.map((e) => LocalizedString.fromJson(e as Map<String, dynamic>))
          .toList(),
      website: json['website'] as String?,
      ircServer: json['ircServer'] as String?,
      ircChannel: json['ircChannel'] as String?,
      discord: json['discord'] as String?,
      contactEmail: json['contactEmail'] as String?,
      description: json['description'] as String?,
      twitter: json['twitter'] as String?,
      mangaUpdates: json['mangaUpdates'] as String?,
      focusedLanguage: (json['focusedLanguage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ScanlationGroupAttributesToJson(
    ScanlationGroupAttributes instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'locked': instance.locked,
    'official': instance.official,
    'inactive': instance.inactive,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('publishDelay', instance.publishDelay);
  writeNotNull('altNames', instance.altNames?.map((e) => e.toJson()).toList());
  writeNotNull('website', instance.website);
  writeNotNull('ircServer', instance.ircServer);
  writeNotNull('ircChannel', instance.ircChannel);
  writeNotNull('discord', instance.discord);
  writeNotNull('contactEmail', instance.contactEmail);
  writeNotNull('description', instance.description);
  writeNotNull('twitter', instance.twitter);
  writeNotNull('mangaUpdates', instance.mangaUpdates);
  writeNotNull('focusedLanguage', instance.focusedLanguage);
  val['createdAt'] = instance.createdAt;
  val['updatedAt'] = instance.updatedAt;
  val['version'] = instance.version;
  return val;
}
