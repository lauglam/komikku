// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaListResponse _$MangaListResponseFromJson(Map<String, dynamic> json) =>
    MangaListResponse(
      response: $enumDecode(_$ResponseTypeEnumMap, json['response']),
      data: (json['data'] as List<dynamic>)
          .map((e) => Manga.fromJson(e as Map<String, dynamic>))
          .toList(),
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$MangaListResponseToJson(MangaListResponse instance) =>
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
