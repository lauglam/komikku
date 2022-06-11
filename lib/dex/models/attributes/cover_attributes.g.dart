// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cover_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoverAttributes _$CoverAttributesFromJson(Map<String, dynamic> json) =>
    CoverAttributes(
      fileName: json['fileName'] as String,
      volume: json['volume'] as String?,
      description: json['description'] as String?,
      locale: json['locale'] as String?,
    );

Map<String, dynamic> _$CoverAttributesToJson(CoverAttributes instance) {
  final val = <String, dynamic>{
    'fileName': instance.fileName,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('volume', instance.volume);
  writeNotNull('description', instance.description);
  writeNotNull('locale', instance.locale);
  return val;
}
