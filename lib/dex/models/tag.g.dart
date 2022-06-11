// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagListResponse _$TagListResponseFromJson(Map<String, dynamic> json) =>
    TagListResponse(
      response: $enumDecode(_$ResponseTypeEnumMap, json['response']),
      data: (json['data'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      limit: json['limit'] as int,
      offset: json['offset'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$TagListResponseToJson(TagListResponse instance) =>
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

TagResponse _$TagResponseFromJson(Map<String, dynamic> json) => TagResponse(
      response: $enumDecode(_$ResponseTypeEnumMap, json['response']),
      data: Tag.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TagResponseToJson(TagResponse instance) =>
    <String, dynamic>{
      'response': _$ResponseTypeEnumMap[instance.response],
      'data': instance.data.toJson(),
    };

Tag _$TagFromJson(Map<String, dynamic> json) => Tag(
      id: json['id'] as String,
      type: $enumDecode(_$EntityTypeEnumMap, json['type']),
      attributes:
          TagAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>)
          .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
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
