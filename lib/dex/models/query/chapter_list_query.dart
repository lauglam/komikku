import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/query/content_rating.dart';
import 'package:komikku/dex/models/query/order_mode.dart';
import 'package:komikku/dex/models/query/date_helper.dart';

/// ChapterList Query
class ChapterListQuery {
  List<String>? ids;
  String? title;
  List<String>? groups;
  String? uploader;
  String? manga;
  List<String>? volume;
  String? chapter;
  List<ContentRating>? contentRating;

  List<String>? translatedLanguage;
  List<String>? originalLanguage;
  List<String>? excludedOriginalLanguage;
  List<String>? excludedGroups;
  List<String>? excludedUploaders;
  List<String>? includeFutureUpdates;

  DateTime? createdAtSince;
  DateTime? updatedAtSince;
  DateTime? publishAtSince;

  List<String>? includes;
  int? limit;
  int? offset;

  ChapterListQuery({
    this.ids,
    this.title,
    this.groups,
    this.uploader,
    this.manga,
    this.volume,
    this.chapter,
    this.contentRating,
    this.translatedLanguage,
    this.originalLanguage,
    this.excludedOriginalLanguage,
    this.excludedGroups,
    this.excludedUploaders,
    this.includeFutureUpdates,
    this.createdAtSince,
    this.updatedAtSince,
    this.publishAtSince,
    this.includes,
    this.limit,
    this.offset,
  });

  factory ChapterListQuery.fromJson(Map<String, dynamic> json) =>
      ChapterListQuery(
        limit: json['limit'] as int?,
        offset: json['offset'] as int?,
        includes: (json['includes[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        createdAtSince: json['createdAtSince'] == null
            ? null
            : parseDate(json['createdAtSince'] as String),
        updatedAtSince: json['updatedAtSince'] == null
            ? null
            : parseDate(json['updatedAtSince'] as String),
        publishAtSince: json['publishAtSince'] == null
            ? null
            : parseDate(json['publishAtSince'] as String),
        translatedLanguage: (json['translatedLanguage[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        originalLanguage: (json['originalLanguage[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        excludedOriginalLanguage:
            (json['excludedOriginalLanguage[]'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList(),
        excludedGroups: (json['excludedGroups[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        excludedUploaders: (json['excludedUploaders[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        includeFutureUpdates: (json['includeFutureUpdates[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        ids:
            (json['ids[]'] as List<dynamic>?)?.map((e) => e as String).toList(),
        title: json['title'] as String?,
        uploader: json['uploader'] as String?,
        manga: json['manga'] as String?,
        groups: (json['groups[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        volume: (json['volume[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        chapter: json['chapter'] as String?,
        contentRating: (json['contentRating[]'] as List<dynamic>?)
            ?.map((e) => $enumDecode(contentRatingEnumMap, e))
            .toList(),
      );

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('limit', limit?.toString());
    writeNotNull('offset', offset?.toString());
    writeNotNull('includes[]', includes);
    writeNotNull('createdAtSince', formatDate(createdAtSince));
    writeNotNull('updatedAtSince', formatDate(updatedAtSince));
    writeNotNull('publishAtSince', formatDate(publishAtSince));
    writeNotNull('translatedLanguage[]', translatedLanguage);
    writeNotNull('originalLanguage[]', originalLanguage);
    writeNotNull('excludedOriginalLanguage[]', excludedOriginalLanguage);
    writeNotNull('excludedGroups[]', excludedGroups);
    writeNotNull('excludedUploaders[]', excludedUploaders);
    writeNotNull('includeFutureUpdates[]', includeFutureUpdates);
    writeNotNull('ids[]', ids);
    writeNotNull('title', title);
    writeNotNull('groups[]', groups);
    writeNotNull('uploader', uploader);
    writeNotNull('manga', manga);
    writeNotNull('volume[]', volume);
    writeNotNull('chapter', chapter);
    writeNotNull('contentRating[]',
        contentRating?.map((e) => contentRatingEnumMap[e]).toList());
    return val;
  }
}

/// ChapterList Order
class ChapterListOrder {
  OrderMode? createdAt;
  OrderMode? updatedAt;
  OrderMode? publishAt;
  OrderMode? readableAt;
  OrderMode? volume;
  OrderMode? chapter;

  ChapterListOrder({
    this.createdAt,
    this.updatedAt,
    this.publishAt,
    this.readableAt,
    this.volume,
    this.chapter,
  });

  String build() {
    var query = '';
    if (createdAt != null) {
      query += '&order[createdAt]=${orderModeEnumMap[createdAt]}';
    }
    if (updatedAt != null) {
      query += '&order[updatedAt]=${orderModeEnumMap[updatedAt]}';
    }
    if (publishAt != null) {
      query += '&order[publishAt]=${orderModeEnumMap[publishAt]}';
    }
    if (readableAt != null) {
      query += '&order[readableAt]=${orderModeEnumMap[readableAt]}';
    }
    if (volume != null) {
      query += '&order[volume]=${orderModeEnumMap[volume]}';
    }
    if (chapter != null) {
      query += '&order[createdAt]=${orderModeEnumMap[chapter]}';
    }
    return query.substring(1);
  }
}
