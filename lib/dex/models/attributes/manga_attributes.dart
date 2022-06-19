import 'package:json_annotation/json_annotation.dart';
import '../localized_string.dart';
import '../enum/state.dart';
import '../enum/status.dart';
import '../enum/content_rating.dart';
import '../enum/publication_demographic.dart';
import '../tag.dart';

part 'manga_attributes.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MangaAttributes {
  /// The title of this manga.
  final LocalizedString title;

  /// Whether this manga is locked.
  final bool isLocked;

  /// The original language of this manga.
  final String originalLanguage;

  /// The content rating of this manga.
  final ContentRating contentRating;

  /// Whether to reset the chapter number of a new volume.
  final bool chapterNumbersResetOnNewVolume;

  /// Available chapter translation languages.
  final List<String?> availableTranslatedLanguages;

  /// The tag list of this manga.
  final List<Tag> tags;

  /// The manga status of this manga.
  final Status status;

  /// The state of this manga.
  final State state;

  /// The alt title of this manga.
  final List<LocalizedString>? altTitles;

  /// The description of this manga.
  /// nullable.
  @JsonKey(readValue: readSingleOrArray)
  final LocalizedString? description;

  /// The last volume of this manga.
  /// nullable.
  final String? lastVolume;

  /// The last chapter of this manga.
  /// nullable.
  final String? lastChapter;

  /// The manga type of this manga.
  /// nullable.
  final PublicationDemographic? publicationDemographic;

  /// The year of this manga.
  /// nullable.
  final int? year;

  /// The link of this manga.
  final dynamic links;

  /// Create date.
  final String createdAt;

  /// Update date.
  final String updatedAt;

  /// The vision of this attributes.
  final int version;

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
    this.altTitles,
    this.description,
    this.lastVolume,
    this.lastChapter,
    this.publicationDemographic,
    this.year,
    this.links,
  });

  factory MangaAttributes.fromJson(Map<String, dynamic> json) =>
      _$MangaAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$MangaAttributesToJson(this);
}
