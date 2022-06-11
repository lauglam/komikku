// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChapterResponse _$ChapterResponseFromJson(Map<String, dynamic> json) =>
    ChapterResponse(
      response: $enumDecode(_$ResponseTypeEnumMap, json['response']),
      data: Chapter.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChapterResponseToJson(ChapterResponse instance) =>
    <String, dynamic>{
      'response': _$ResponseTypeEnumMap[instance.response],
      'data': instance.data.toJson(),
    };

const _$ResponseTypeEnumMap = {
  ResponseType.entity: 'entity',
  ResponseType.collection: 'collection',
};

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      id: json['id'] as String,
      type: $enumDecode(_$EntityTypeEnumMap, json['type']),
      attributes: ChapterAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>)
          .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$EntityTypeEnumMap[instance.type],
      'attributes': instance.attributes.toJson(),
      'relationships': instance.relationships.map((e) => e.toJson()).toList(),
    };

const _$EntityTypeEnumMap = {
  EntityType.manga: 'manga',
  EntityType.tag: 'tag',
  EntityType.coverArt: 'cover_art',
  EntityType.chapter: 'chapter',
  EntityType.scanlationGroup: 'scanlation_group',
  EntityType.user: 'user',
  EntityType.customList: 'custom_list',
  EntityType.author: 'author',
  EntityType.artist: 'artist',
  EntityType.mappingId: 'mapping_id',
  EntityType.mangaRelation: 'manga_relation',
  EntityType.uploadSession: 'upload_session',
  EntityType.uploadSessionFile: 'upload_session_file',
  EntityType.report: 'report',
};
