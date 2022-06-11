// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_read_marker.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterReadMarkerResponse _$ChapterReadMarkerResponseFromJson(
        Map<String, dynamic> json) =>
    ChapterReadMarkerResponse(
      result: $enumDecode(_$ResultEnumMap, json['result']),
      data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ChapterReadMarkerResponseToJson(
        ChapterReadMarkerResponse instance) =>
    <String, dynamic>{
      'result': _$ResultEnumMap[instance.result],
      'data': instance.data,
    };

const _$ResultEnumMap = {
  Result.ok: 'ok',
  Result.error: 'error',
};

GroupedChapterReadMarkerResponse _$GroupedChapterReadMarkerResponseFromJson(
        Map<String, dynamic> json) =>
    GroupedChapterReadMarkerResponse(
      result: $enumDecode(_$ResultEnumMap, json['result']),
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
    );

Map<String, dynamic> _$GroupedChapterReadMarkerResponseToJson(
        GroupedChapterReadMarkerResponse instance) =>
    <String, dynamic>{
      'result': _$ResultEnumMap[instance.result],
      'data': instance.data,
    };

ChapterReadMarkerBatch _$ChapterReadMarkerBatchFromJson(
        Map<String, dynamic> json) =>
    ChapterReadMarkerBatch(
      chapterIdsRead: (json['chapterIdsRead'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      chapterIdsUnread: (json['chapterIdsUnread'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ChapterReadMarkerBatchToJson(
    ChapterReadMarkerBatch instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('chapterIdsRead', instance.chapterIdsRead);
  writeNotNull('chapterIdsUnread', instance.chapterIdsUnread);
  return val;
}
