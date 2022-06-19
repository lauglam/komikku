import 'package:json_annotation/json_annotation.dart';
import '../localized_string.dart';

part 'author_attributes.g.dart';

/// 作者属性
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AuthorAttributes {
  /// 作者名
  final String name;

  /// 图片地址
  final String? imageUrl;

  /// 传记
  @JsonKey(readValue: readSingleOrArray)
  final LocalizedString? biography;

  /// twitter
  final String? twitter;

  /// pixiv
  final String? pixiv;

  /// melonBook
  final String? melonBook;

  /// fanBox
  final String? fanBox;

  /// booth
  final String? booth;

  /// nicoVideo
  final String? nicoVideo;

  /// skeb
  final String? skeb;

  /// fantia
  final String? fantia;

  /// tumber
  final String? tumber;

  /// youtube
  final String? youtube;

  /// weibo
  final String? weibo;

  /// naver
  final String? naver;

  /// website
  final String? website;

  /// 创建时间
  final String createdAt;

  /// 更新时间
  final String updatedAt;

  /// 版本
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

  factory AuthorAttributes.fromJson(Map<String, dynamic> json) => _$AuthorAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorAttributesToJson(this);
}
