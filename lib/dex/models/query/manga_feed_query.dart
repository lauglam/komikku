import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/query/chapter_list_query.dart';
import 'package:komikku/dex/models/enum/content_rating.dart';
import 'package:komikku/dex/models/util.dart';

/// MangaFeed Query
class MangaFeedQuery {
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
            json['createdAtSince'] == null ? null : parseDate(json['createdAtSince'] as String),
        updatedAtSince:
            json['updatedAtSince'] == null ? null : parseDate(json['updatedAtSince'] as String),
        publishAtSince:
            json['publishAtSince'] == null ? null : parseDate(json['publishAtSince'] as String),
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
    writeNotNull('createdAtSince', formatDate(createdAtSince));
    writeNotNull('updatedAtSince', formatDate(updatedAtSince));
    writeNotNull('publishAtSince', formatDate(publishAtSince));
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
