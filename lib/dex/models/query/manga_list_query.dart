import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/query/content_rating.dart';
import 'package:komikku/dex/models/query/extensions.dart';
import 'package:komikku/dex/models/query/order_mode.dart';
import 'package:komikku/dex/models/query/publication_demographic.dart';
import 'package:komikku/dex/models/query/tags_mode.dart';

/// MangaList Query
class MangaListQuery {
  @JsonKey(includeIfNull: false)
  List<String>? ids;
  String? title;
  String? group;
  bool? hasAvailableChapters;
  List<String>? authors;
  List<String>? artists;
  int? year;
  List<String>? includedTags;
  TagsMode? includedTagsMode;
  List<String>? excludedTags;
  TagsMode? excludedTagsMode;
  List<String>? status;
  List<String>? originalLanguage;
  List<String>? excludedOriginalLanguage;
  List<String>? availableTranslatedLanguage;
  List<PublicationDemographic>? publicationDemographic;
  List<ContentRating>? contentRating;

  DateTime? createdAtSince;
  DateTime? updatedAtSince;

  List<String>? includes;
  int? limit;
  int? offset;

  MangaListQuery({
    this.ids,
    this.title,
    this.group,
    this.hasAvailableChapters,
    this.authors,
    this.artists,
    this.year,
    this.includedTags,
    this.includedTagsMode,
    this.excludedTags,
    this.excludedTagsMode,
    this.status,
    this.originalLanguage,
    this.excludedOriginalLanguage,
    this.availableTranslatedLanguage,
    this.publicationDemographic,
    this.contentRating,
    this.createdAtSince,
    this.updatedAtSince,
    this.includes,
    this.limit,
    this.offset,
  });

  factory MangaListQuery.fromJson(Map<String, dynamic> json) => MangaListQuery(
        ids:
            (json['ids[]'] as List<dynamic>?)?.map((e) => e as String).toList(),
        title: json['title'] as String?,
        group: json['group'] as String?,
        hasAvailableChapters: json['hasAvailableChapters'] as bool?,
        authors: (json['authors[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        artists: (json['artists[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        year: json['year'] as int?,
        includedTags: (json['includedTags[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        includedTagsMode:
            $enumDecodeNullable(tagsModeEnumMap, json['includedTagsMode']),
        excludedTags: (json['excludedTags[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        excludedTagsMode:
            $enumDecodeNullable(tagsModeEnumMap, json['excludedTagsMode']),
        status: (json['status[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        originalLanguage: (json['originalLanguage[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        excludedOriginalLanguage:
            (json['excludedOriginalLanguage[]'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList(),
        availableTranslatedLanguage:
            (json['availableTranslatedLanguage[]'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList(),
        publicationDemographic:
            (json['publicationDemographic[]'] as List<dynamic>?)
                ?.map((e) => $enumDecode(publicationDemographicEnumMap, e))
                .toList(),
        contentRating: (json['contentRating[]'] as List<dynamic>?)
            ?.map((e) => $enumDecode(contentRatingEnumMap, e))
            .toList(),
        createdAtSince: json['createdAtSince'] == null
            ? null
            : (json['createdAtSince'] as String).parse(),
        updatedAtSince: json['updatedAtSince'] == null
            ? null
            : (json['updatedAtSince'] as String).parse(),
        includes: (json['includes[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        limit: json['limit'] as int?,
        offset: json['offset'] as int?,
      );

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('ids[]', ids);
    writeNotNull('title', title);
    writeNotNull('group', group);
    writeNotNull('hasAvailableChapters', hasAvailableChapters);
    writeNotNull('authors[]', authors);
    writeNotNull('artists[]', artists);
    writeNotNull('year', year);
    writeNotNull('includedTags[]', includedTags);
    writeNotNull('includedTagsMode', tagsModeEnumMap[includedTagsMode]);
    writeNotNull('excludedTags[]', excludedTags);
    writeNotNull('excludedTagsMode', tagsModeEnumMap[excludedTagsMode]);
    writeNotNull('status[]', status);
    writeNotNull('originalLanguage[]', originalLanguage);
    writeNotNull('excludedOriginalLanguage[]', excludedOriginalLanguage);
    writeNotNull('availableTranslatedLanguage[]', availableTranslatedLanguage);
    writeNotNull(
        'publicationDemographic[]',
        publicationDemographic
            ?.map((e) => publicationDemographicEnumMap[e])
            .toList());
    writeNotNull('contentRating[]',
        contentRating?.map((e) => contentRatingEnumMap[e]).toList());
    writeNotNull('createdAtSince', createdAtSince?.format());
    writeNotNull('updatedAtSince', updatedAtSince?.format());
    writeNotNull('includes[]', includes);
    writeNotNull('limit', limit?.toString());
    writeNotNull('offset', offset?.toString());
    return val;
  }
}

/// MangaList Order
class MangaListOrder {
  OrderMode? title;
  OrderMode? year;
  OrderMode? createdAt;
  OrderMode? updatedAt;
  OrderMode? latestUploadedChapter;
  OrderMode? followedCount;
  OrderMode? relevance;

  MangaListOrder({
    this.title,
    this.year,
    this.createdAt,
    this.updatedAt,
    this.latestUploadedChapter,
    this.followedCount,
    this.relevance,
  });

  String build(bool onlyOrder) {
    var query = '';
    if (title != null) {
      query += '&order[title]=${orderModeEnumMap[title]}';
    }
    if (year != null) {
      query += '&order[year]=${orderModeEnumMap[year]}';
    }
    if (createdAt != null) {
      query += '&order[createdAt]=${orderModeEnumMap[createdAt]}';
    }
    if (updatedAt != null) {
      query += '&order[updatedAt]=${orderModeEnumMap[updatedAt]}';
    }
    if (latestUploadedChapter != null) {
      query +=
          '&order[latestUploadedChapter]=${orderModeEnumMap[latestUploadedChapter]}';
    }
    if (followedCount != null) {
      query += '&order[followedCount]=${orderModeEnumMap[followedCount]}';
    }
    if (relevance != null) {
      query += '&order[relevance]=${orderModeEnumMap[relevance]}';
    }
    return onlyOrder ? '?${query.substring(1)}' : query;
  }
}
