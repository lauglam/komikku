import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/query/chapter_list_query.dart';
import 'package:komikku/dex/models/enum/content_rating.dart';

/// MangaFeed Query
class MangaFeedQuery {
  final List<ContentRating>? contentRating;

  final List<String>? translatedLanguage;
  final List<String>? originalLanguage;
  final List<String>? excludedOriginalLanguage;
  final List<String>? excludedGroups;
  final List<String>? excludedUploaders;
  final List<String>? includeFutureUpdates;

  final DateTime? createdAtSince;
  final DateTime? updatedAtSince;
  final DateTime? publishAtSince;

  final List<String>? includes;
  final int? limit;
  final int? offset;

  MangaFeedQuery({
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

  factory MangaFeedQuery.fromJson(Map<String, dynamic> json) => MangaFeedQuery(
        limit: json['limit'] as int?,
        offset: json['offset'] as int?,
        includes: (json['includes[]'] as List<dynamic>?)?.map((e) => e as String).toList(),
        createdAtSince:
            json['createdAtSince'] == null ? null : DateTime.parse(json['createdAtSince'] as String),
        updatedAtSince:
            json['updatedAtSince'] == null ? null : DateTime.parse(json['updatedAtSince'] as String),
        publishAtSince:
            json['publishAtSince'] == null ? null : DateTime.parse(json['publishAtSince'] as String),
        translatedLanguage:
            (json['translatedLanguage[]'] as List<dynamic>?)?.map((e) => e as String).toList(),
        originalLanguage:
            (json['originalLanguage[]'] as List<dynamic>?)?.map((e) => e as String).toList(),
        excludedOriginalLanguage: (json['excludedOriginalLanguage[]'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        excludedGroups:
            (json['excludedGroups[]'] as List<dynamic>?)?.map((e) => e as String).toList(),
        excludedUploaders:
            (json['excludedUploaders[]'] as List<dynamic>?)?.map((e) => e as String).toList(),
        includeFutureUpdates:
            (json['includeFutureUpdates[]'] as List<dynamic>?)?.map((e) => e as String).toList(),
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
    writeNotNull('createdAtSince', createdAtSince?.toIso8601String());
    writeNotNull('updatedAtSince', updatedAtSince?.toIso8601String());
    writeNotNull('publishAtSince', publishAtSince?.toIso8601String());
    writeNotNull('translatedLanguage[]', translatedLanguage);
    writeNotNull('originalLanguage[]', originalLanguage);
    writeNotNull('excludedOriginalLanguage[]', excludedOriginalLanguage);
    writeNotNull('excludedGroups[]', excludedGroups);
    writeNotNull('excludedUploaders[]', excludedUploaders);
    writeNotNull('includeFutureUpdates[]', includeFutureUpdates);
    writeNotNull('contentRating[]', contentRating?.map((e) => contentRatingEnumMap[e]).toList());
    return val;
  }
}

/// MangaFeed Order
typedef MangaFeedOrder = ChapterListOrder;
