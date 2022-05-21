import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/enum/state.dart';
import 'package:komikku/dex/models/enum/status.dart';
import 'package:komikku/dex/models/localized_string.dart';
import 'package:komikku/dex/models/query/content_rating.dart';
import 'package:komikku/dex/models/query/publication_demographic.dart';
import 'package:komikku/dex/models/tag.dart';

class MangaAttributes {
  LocalizedString title;
  bool isLocked;
  String originalLanguage;
  ContentRating contentRating;
  bool chapterNumbersResetOnNewVolume;
  List<String?> availableTranslatedLanguages;
  List<Tag> tags;
  Status status;
  State state;
  List<LocalizedString>? altTitle;
  LocalizedString? description;
  String? lastVolume;
  String? lastChapter;
  PublicationDemographic? publicationDemographic;
  int? year;
  dynamic links;

  String createdAt;
  String updatedAt;
  int version;

  MangaAttributes({
    required this.title,
    required this.isLocked,
    required this.originalLanguage,
    required this.contentRating,
    required this.chapterNumbersResetOnNewVolume,
    required this.availableTranslatedLanguages,
    required this.tags,
    required this.status,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.altTitle,
    this.description,
    this.lastVolume,
    this.lastChapter,
    this.publicationDemographic,
    this.year,
    this.links,
  });

  factory MangaAttributes.fromJson(Map<String, dynamic> json) =>
      MangaAttributes(
        title: LocalizedString.fromJson(json['title'] as Map<String, dynamic>),
        isLocked: json['isLocked'] as bool,
        originalLanguage: json['originalLanguage'] as String,
        contentRating: $enumDecode(contentRatingEnumMap, json['contentRating']),
        chapterNumbersResetOnNewVolume:
            json['chapterNumbersResetOnNewVolume'] as bool,
        availableTranslatedLanguages:
            (json['availableTranslatedLanguages'] as List<dynamic>)
                .map((e) => e as String?)
                .toList(),
        tags: (json['tags'] as List<dynamic>)
            .map((e) => Tag.fromJson(e as Map<String, dynamic>))
            .toList(),
        status: $enumDecode(statusEnumMap, json['status']),
        state: $enumDecode(stateEnumMap, json['state']),
        createdAt: json['createdAt'] as String,
        updatedAt: json['updatedAt'] as String,
        version: json['version'] as int,
        altTitle: json['altTitle'] == null
            ? null
            : (json['altTitle'] as List<dynamic>)
                .map((e) => LocalizedString.fromJson(e as Map<String, dynamic>))
                .toList(),
        description: json['description'] == null
            ? null
            : json['description'] is Iterable
                ? null
                : LocalizedString.fromJson(
                    json['description'] as Map<String, dynamic>),
        lastVolume: json['lastVolume'] as String?,
        lastChapter: json['lastChapter'] as String?,
        publicationDemographic: $enumDecodeNullable(
            publicationDemographicEnumMap, json['publicationDemographic']),
        year: json['year'] as int?,
        links: json['links'],
      );

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    val['title'] = title;
    val['isLocked'] = isLocked;
    val['originalLanguage'] = originalLanguage;
    val['contentRating'] = contentRatingEnumMap[contentRating];
    val['chapterNumbersResetOnNewVolume'] = chapterNumbersResetOnNewVolume;
    val['availableTranslatedLanguages'] = availableTranslatedLanguages;
    val['tags'] = tags;
    val['status'] = statusEnumMap[status];
    val['state'] = stateEnumMap[state];
    writeNotNull('altTitle', altTitle);
    writeNotNull('description', description);
    writeNotNull('lastVolume', lastVolume);
    writeNotNull('lastChapter', lastChapter);
    writeNotNull('publicationDemographic',
        publicationDemographicEnumMap[publicationDemographic]);
    writeNotNull('year', year);
    writeNotNull('links', links);
    writeNotNull('createdAt', createdAt);
    writeNotNull('updatedAt', updatedAt);
    writeNotNull('version', version);
    return val;
  }
}
