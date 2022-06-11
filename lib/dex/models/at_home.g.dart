// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'at_home.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtHome _$AtHomeFromJson(Map<String, dynamic> json) => AtHome(
      baseUrl: json['baseUrl'] as String,
      chapter: AtHomeChapter.fromJson(json['chapter'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AtHomeToJson(AtHome instance) => <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'chapter': instance.chapter.toJson(),
    };
