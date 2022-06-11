// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Manga _$MangaFromJson(Map<String, dynamic> json) => Manga(
      id: json['id'] as String,
      type: $enumDecode(_$EntityTypeEnumMap, json['type']),
      attributes:
          MangaAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>)
          .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MangaToJson(Manga instance) => <String, dynamic>{
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
