// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterAttributes _$ChapterAttributesFromJson(Map<String, dynamic> json) =>
    ChapterAttributes(
      publishAt: json['publishAt'] as String,
      readableAt: json['readableAt'] as String,
      translatedLanguage: json['translatedLanguage'] as String,
      pages: json['pages'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: json['version'] as int,
      title: json['title'] as String?,
      uploader: json['uploader'] as String?,
      volume: json['volume'] as String?,
      chapter: json['chapter'] as String?,
      externalUrl: json['externalUrl'] as String?,
    );

Map<String, dynamic> _$ChapterAttributesToJson(ChapterAttributes instance) {
  final val = <String, dynamic>{
    'publishAt': instance.publishAt,
    'readableAt': instance.readableAt,
    'translatedLanguage': instance.translatedLanguage,
    'pages': instance.pages,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('uploader', instance.uploader);
  writeNotNull('volume', instance.volume);
  writeNotNull('chapter', instance.chapter);
  writeNotNull('externalUrl', instance.externalUrl);
  val['createdAt'] = instance.createdAt;
  val['updatedAt'] = instance.updatedAt;
  val['version'] = instance.version;
  return val;
}
