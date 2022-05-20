import 'package:komikku/dex/models/localized_string.dart';

class AuthorAttributes {
  String name;
  String imageUrl;
  LocalizedString? biography;
  String? twitter;
  String? pixiv;
  String? melonBook;
  String? fanBox;
  String? booth;
  String? nicoVideo;
  String? skeb;
  String? fantia;
  String? tumber;
  String? youtube;
  String? weibo;
  String? naver;
  String? website;

  AuthorAttributes({
    required this.name,
    required this.imageUrl,
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
      AuthorAttributes(
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String,
        biography: json['biography'] == null
            ? null
            : json['biography'] == '[]'
                ? null
                : LocalizedString.fromJson(
                    json['biography'] as Map<String, dynamic>),
        twitter: json['twitter'] as String?,
        pixiv: json['pixiv'] as String?,
        melonBook: json['melonBook'] as String?,
        fanBox: json['fanBox'] as String?,
        booth: json['booth'] as String?,
        nicoVideo: json['nicoVideo'] as String?,
        skeb: json['skeb'] as String?,
        fantia: json['fantia'] as String?,
        tumber: json['tumber'] as String?,
        youtube: json['youtube'] as String?,
        weibo: json['weibo'] as String?,
        naver: json['naver'] as String?,
        website: json['website'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'biography': biography,
        'twitter': twitter,
        'pixiv': pixiv,
        'melonBook': melonBook,
        'fanBox': fanBox,
        'booth': booth,
        'nicoVideo': nicoVideo,
        'skeb': skeb,
        'fantia': fantia,
        'tumber': tumber,
        'youtube': youtube,
        'weibo': weibo,
        'naver': naver,
        'website': website,
      };
}
