// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaAttributes _$MangaAttributesFromJson(Map<String, dynamic> json) =>
    MangaAttributes(
      title: LocalizedString.fromJson(json['title'] as Map<String, dynamic>),
      isLocked: json['isLocked'] as bool,
      originalLanguage: json['originalLanguage'] as String,
      contentRating: $enumDecode(_$ContentRatingEnumMap, json['contentRating']),
      chapterNumbersResetOnNewVolume:
          json['chapterNumbersResetOnNewVolume'] as bool,
      availableTranslatedLanguages:
          (json['availableTranslatedLanguages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      tags: (json['tags'] as List<dynamic>)
          .map((e) => Tag.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: $enumDecode(_$StatusEnumMap, json['status']),
      state: $enumDecode(_$StateEnumMap, json['state']),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: json['version'] as int,
      altTitles: (json['altTitles'] as List<dynamic>?)
          ?.map((e) => LocalizedString.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: readSingleOrArray(json, 'description') == null
          ? null
          : LocalizedString.fromJson(
              readSingleOrArray(json, 'description') as Map<String, dynamic>),
      lastVolume: json['lastVolume'] as String?,
      lastChapter: json['lastChapter'] as String?,
      publicationDemographic: $enumDecodeNullable(
          _$PublicationDemographicEnumMap, json['publicationDemographic']),
      year: json['year'] as int?,
      links: json['links'],
    );

Map<String, dynamic> _$MangaAttributesToJson(MangaAttributes instance) {
  final val = <String, dynamic>{
    'title': instance.title.toJson(),
    'isLocked': instance.isLocked,
    'originalLanguage': instance.originalLanguage,
    'contentRating': _$ContentRatingEnumMap[instance.contentRating],
    'chapterNumbersResetOnNewVolume': instance.chapterNumbersResetOnNewVolume,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'availableTranslatedLanguages', instance.availableTranslatedLanguages);
  val['tags'] = instance.tags.map((e) => e.toJson()).toList();
  val['status'] = _$StatusEnumMap[instance.status];
  val['state'] = _$StateEnumMap[instance.state];
  writeNotNull('altTitles', instance.altTitles?.map((e) => e.toJson()).toList());
  writeNotNull('description', instance.description?.toJson());
  writeNotNull('lastVolume', instance.lastVolume);
  writeNotNull('lastChapter', instance.lastChapter);
  writeNotNull('publicationDemographic',
      _$PublicationDemographicEnumMap[instance.publicationDemographic]);
  writeNotNull('year', instance.year);
  writeNotNull('links', instance.links);
  val['createdAt'] = instance.createdAt;
  val['updatedAt'] = instance.updatedAt;
  val['version'] = instance.version;
  return val;
}

const _$ContentRatingEnumMap = {
  ContentRating.safe: 'safe',
  ContentRating.suggestive: 'suggestive',
  ContentRating.erotica: 'erotica',
  ContentRating.pornographic: 'pornographic',
};

const _$StatusEnumMap = {
  Status.ongoing: 'ongoing',
  Status.completed: 'completed',
  Status.hiatus: 'hiatus',
  Status.cancelled: 'cancelled',
};

const _$StateEnumMap = {
  State.draft: 'draft',
  State.submitted: 'submitted',
  State.published: 'published',
  State.rejected: 'rejected',
};

const _$PublicationDemographicEnumMap = {
  PublicationDemographic.shounen: 'shounen',
  PublicationDemographic.shoujo: 'shoujo',
  PublicationDemographic.josei: 'josei',
  PublicationDemographic.seinen: 'seinen',
};
