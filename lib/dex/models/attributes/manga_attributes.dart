import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/enum/state.dart';
import 'package:komikku/dex/models/enum/status.dart';
import 'package:komikku/dex/models/localized_string.dart';
import 'package:komikku/dex/models/enum/content_rating.dart';
import 'package:komikku/dex/models/enum/publication_demographic.dart';
import 'package:komikku/dex/models/tag.dart';

class MangaAttributes {
  final LocalizedString title;
  final bool isLocked;
  final String originalLanguage;
  final ContentRating contentRating;
  final bool chapterNumbersResetOnNewVolume;
  final List<String?> availableTranslatedLanguages;
  final List<Tag> tags;
  final Status status;
  final State state;
  final List<LocalizedString>? altTitle;
  final LocalizedString? description;
  final String? lastVolume;
  final String? lastChapter;
  final PublicationDemographic? publicationDemographic;
  final int? year;
  final dynamic links;

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

    val['title'] = title.toJson();
    val['isLocked'] = isLocked;
    val['originalLanguage'] = originalLanguage;
    val['contentRating'] = contentRatingEnumMap[contentRating];
    val['chapterNumbersResetOnNewVolume'] = chapterNumbersResetOnNewVolume;
    val['availableTranslatedLanguages'] = availableTranslatedLanguages;
    val['tags'] = tags.map((e) => e.toJson()).toList();
    val['status'] = statusEnumMap[status];
    val['state'] = stateEnumMap[state];
    writeNotNull('altTitle', altTitle?.map((e) => e.toJson()).toList());
    writeNotNull('description', description?.toJson());
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
