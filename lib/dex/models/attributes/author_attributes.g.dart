// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorAttributes _$AuthorAttributesFromJson(Map<String, dynamic> json) =>
    AuthorAttributes(
      name: json['name'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: json['version'] as int,
      imageUrl: json['imageUrl'] as String?,
      biography: readSingleOrArray(json, 'biography') == null
          ? null
          : LocalizedString.fromJson(
              readSingleOrArray(json, 'biography') as Map<String, dynamic>),
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

Map<String, dynamic> _$AuthorAttributesToJson(AuthorAttributes instance) {
  final val = <String, dynamic>{
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('imageUrl', instance.imageUrl);
  writeNotNull('biography', instance.biography?.toJson());
  writeNotNull('twitter', instance.twitter);
  writeNotNull('pixiv', instance.pixiv);
  writeNotNull('melonBook', instance.melonBook);
  writeNotNull('fanBox', instance.fanBox);
  writeNotNull('booth', instance.booth);
  writeNotNull('nicoVideo', instance.nicoVideo);
  writeNotNull('skeb', instance.skeb);
  writeNotNull('fantia', instance.fantia);
  writeNotNull('tumber', instance.tumber);
  writeNotNull('youtube', instance.youtube);
  writeNotNull('weibo', instance.weibo);
  writeNotNull('naver', instance.naver);
  writeNotNull('website', instance.website);
  val['createdAt'] = instance.createdAt;
  val['updatedAt'] = instance.updatedAt;
  val['version'] = instance.version;
  return val;
}
