import 'package:komikku/dex/models/localized_string.dart';

class AuthorAttributes {
  String name;
  String? imageUrl;
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

  String createdAt;
  String updatedAt;
  int version;

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

  factory AuthorAttributes.fromJson(Map<String, dynamic> json) => AuthorAttributes(
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String?,
        createdAt: json['createdAt'] as String,
        updatedAt: json['updatedAt'] as String,
        version: json['version'] as int,
        biography: json['biography'] == null
            ? null
            : json['biography'] is Iterable
                ? null
                : LocalizedString.fromJson(json['biography'] as Map<String, dynamic>),
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

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    val['name'] = name;
    val['createdAt'] = createdAt;
    val['updatedAt'] = updatedAt;
    val['version'] = version;
    writeNotNull('imageUrl', imageUrl);
    writeNotNull('biography', biography?.toJson());
    writeNotNull('twitter', twitter);
    writeNotNull('pixiv', pixiv);
    writeNotNull('melonBook', melonBook);
    writeNotNull('fanBox', fanBox);
    writeNotNull('booth', booth);
    writeNotNull('nicoVideo', nicoVideo);
    writeNotNull('skeb', skeb);
    writeNotNull('fantia', fantia);
    writeNotNull('tumber', tumber);
    writeNotNull('youtube', youtube);
    writeNotNull('weibo', weibo);
    writeNotNull('naver', naver);
    writeNotNull('website', website);
    return val;
  }
}
