// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relationship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Relationship _$RelationshipFromJson(Map<String, dynamic> json) => Relationship(
      id: json['id'] as String,
      type: $enumDecode(_$EntityTypeEnumMap, json['type']),
      related: $enumDecodeNullable(_$RelatedEnumMap, json['related']),
      attributes: json['attributes'],
    );

Map<String, dynamic> _$RelationshipToJson(Relationship instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'type': _$EntityTypeEnumMap[instance.type],
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('related', _$RelatedEnumMap[instance.related]);
  writeNotNull('attributes', instance.attributes);
  return val;
}

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

const _$RelatedEnumMap = {
  Related.monochrome: 'monochrome',
  Related.colored: 'colored',
  Related.preserialization: 'preserialization',
  Related.serialization: 'serialization',
  Related.prequel: 'prequel',
  Related.sequel: 'sequel',
  Related.mainStory: 'main_story',
  Related.sideStory: 'side_story',
  Related.adaptedFrom: 'adapted_from',
  Related.spinOff: 'spin_off',
  Related.basedOn: 'based_on',
  Related.douJinShi: 'doujinshi',
  Related.sameFranchise: 'same_franchise',
  Related.sharedUniverse: 'shared_universe',
  Related.alternateStory: 'alternate_story',
  Related.alternateVersion: 'alternate_version',
};
