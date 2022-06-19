import 'package:json_annotation/json_annotation.dart';
import '../localized_string.dart';

part 'author_attributes.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AuthorAttributes {
  /// Author name.
  final String name;

  /// The cover image url.
  final String? imageUrl;

  /// The biography of author.
  @JsonKey(readValue: readSingleOrArray)
  final LocalizedString? biography;

  /// twitter.
  /// nullable.
  final String? twitter;

  /// pixiv.
  /// nullable.
  final String? pixiv;

  /// melonBook.
  /// nullable.
  final String? melonBook;

  /// fanBox
  /// nullable.
  final String? fanBox;

  /// booth
  /// nullable.
  final String? booth;

  /// nicoVideo
  /// nullable.
  final String? nicoVideo;

  /// skeb
  /// nullable.
  final String? skeb;

  /// fantia
  /// nullable.
  final String? fantia;

  /// tumber
  /// nullable.
  final String? tumber;

  /// youtube
  /// nullable.
  final String? youtube;

  /// weibo
  /// nullable.
  final String? weibo;

  /// naver
  /// nullable.
  final String? naver;

  /// website
  /// nullable.
  final String? website;

  /// Create date.
  final String createdAt;

  /// Update date.
  final String updatedAt;

  /// The vision of this attributes.
  final int version;

  AuthorAttributes({
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.imageUrl,
    this.biography,
    this.twitter,
    this.pixiv,
    this.melonBook,
    this.fanBox,
    this.booth,
    this.nicoVideo,
    this.skeb,
    this.fantia,
    this.tumber,
    this.youtube,
    this.weibo,
    this.naver,
    this.website,
  });

  factory AuthorAttributes.fromJson(Map<String, dynamic> json) =>
      _$AuthorAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorAttributesToJson(this);
}
