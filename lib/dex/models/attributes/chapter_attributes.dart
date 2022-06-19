import 'package:json_annotation/json_annotation.dart';

part 'chapter_attributes.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChapterAttributes {
  /// Publish date.
  final String publishAt;

  /// Readable date.
  final String readableAt;

  /// Translated language.
  final String translatedLanguage;

  /// Page count of this chapter.
  final int pages;

  /// The title of this chapter.
  /// nullable.
  final String? title;

  /// The upload of this chapter.
  /// nullable.
  final String? uploader;

  /// The volume belong to.
  /// nullable.
  final String? volume;

  /// The chapter index of this chapter.
  /// nullable.
  final String? chapter;

  /// External url.
  /// nullable.
  final String? externalUrl;

  /// Create date.
  final String createdAt;

  /// Update date.
  final String updatedAt;

  /// The vision of this attributes.
  final int version;

  ChapterAttributes({
    required this.publishAt,
    required this.readableAt,
    required this.translatedLanguage,
    required this.pages,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.title,
    this.uploader,
    this.volume,
    this.chapter,
    this.externalUrl,
  });

  factory ChapterAttributes.fromJson(Map<String, dynamic> json) =>
      _$ChapterAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$ChapterAttributesToJson(this);
}
