// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterListResponse _$ChapterListResponseFromJson(Map<String, dynamic> json) =>
    ChapterListResponse(
      response: $enumDecode(_$ResponseTypeEnumMap, json['response']),
      data: (json['data'] as List<dynamic>)
          .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$ChapterListResponseToJson(
        ChapterListResponse instance) =>
    <String, dynamic>{
      'response': _$ResponseTypeEnumMap[instance.response],
      'data': instance.data.map((e) => e.toJson()).toList(),
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };

const _$ResponseTypeEnumMap = {
  ResponseType.entity: 'entity',
  ResponseType.collection: 'collection',
};
