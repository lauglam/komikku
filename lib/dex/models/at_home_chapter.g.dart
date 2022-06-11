// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'at_home_chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtHomeChapter _$AtHomeChapterFromJson(Map<String, dynamic> json) =>
    AtHomeChapter(
      hash: json['hash'] as String,
      data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
      dataSaver:
          (json['dataSaver'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AtHomeChapterToJson(AtHomeChapter instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'data': instance.data,
      'dataSaver': instance.dataSaver,
    };
