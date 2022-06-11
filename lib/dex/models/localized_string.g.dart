// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localized_string.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalizedString _$LocalizedStringFromJson(Map<String, dynamic> json) =>
    LocalizedString(
      english: json['en'] as String?,
      arabic: json['ar'] as String?,
      bengali: json['bn'] as String?,
      bulgarian: json['bg'] as String?,
      burmese: json['my'] as String?,
      catalan: json['ca'] as String?,
      chineseSimplified: json['zh'] as String?,
      chineseTraditional: json['zh-hk'] as String?,
      chineseRoman: json['zh-ro'] as String?,
      croatian: json['hr'] as String?,
      czech: json['cs'] as String?,
      danish: json['da'] as String?,
      dutch: json['nl'] as String?,
      esperanto: json['eo'] as String?,
      estonian: json['et'] as String?,
      filipino: json['tl'] as String?,
      finnish: json['fi'] as String?,
      french: json['fr'] as String?,
      german: json['de'] as String?,
      greek: json['el'] as String?,
      hebrew: json['he'] as String?,
      hindi: json['hi'] as String?,
      hungarian: json['hu'] as String?,
      indonesian: json['id'] as String?,
      italian: json['it'] as String?,
      japanese: json['ja'] as String?,
      japaneseRoman: json['ja-ro'] as String?,
      korean: json['ko'] as String?,
      koreanRoman: json['ko-ro'] as String?,
      latin: json['la'] as String?,
      lithuanian: json['lt'] as String?,
      malay: json['ms'] as String?,
      mongolian: json['mn'] as String?,
      nepali: json['ne'] as String?,
      norwegian: json['no'] as String?,
      persian: json['fa'] as String?,
      polish: json['pl'] as String?,
      portuguese: json['pt'] as String?,
      portugueseBr: json['pt-br'] as String?,
      romanian: json['ro'] as String?,
      russian: json['ru'] as String?,
      serbian: json['sr'] as String?,
      spanish: json['es'] as String?,
      spanishLATAM: json['es-la'] as String?,
      swedish: json['sv'] as String?,
      thai: json['th'] as String?,
      turkish: json['tr'] as String?,
      ukrainian: json['uk'] as String?,
      vietnamese: json['vi'] as String?,
    );

Map<String, dynamic> _$LocalizedStringToJson(LocalizedString instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('en', instance.english);
  writeNotNull('ar', instance.arabic);
  writeNotNull('bn', instance.bengali);
  writeNotNull('bg', instance.bulgarian);
  writeNotNull('my', instance.burmese);
  writeNotNull('ca', instance.catalan);
  writeNotNull('zh', instance.chineseSimplified);
  writeNotNull('zh-hk', instance.chineseTraditional);
  writeNotNull('zh-ro', instance.chineseRoman);
  writeNotNull('hr', instance.croatian);
  writeNotNull('cs', instance.czech);
  writeNotNull('da', instance.danish);
  writeNotNull('nl', instance.dutch);
  writeNotNull('eo', instance.esperanto);
  writeNotNull('et', instance.estonian);
  writeNotNull('tl', instance.filipino);
  writeNotNull('fi', instance.finnish);
  writeNotNull('fr', instance.french);
  writeNotNull('de', instance.german);
  writeNotNull('el', instance.greek);
  writeNotNull('he', instance.hebrew);
  writeNotNull('hi', instance.hindi);
  writeNotNull('hu', instance.hungarian);
  writeNotNull('id', instance.indonesian);
  writeNotNull('it', instance.italian);
  writeNotNull('ja', instance.japanese);
  writeNotNull('ja-ro', instance.japaneseRoman);
  writeNotNull('ko', instance.korean);
  writeNotNull('ko-ro', instance.koreanRoman);
  writeNotNull('la', instance.latin);
  writeNotNull('lt', instance.lithuanian);
  writeNotNull('ms', instance.malay);
  writeNotNull('mn', instance.mongolian);
  writeNotNull('ne', instance.nepali);
  writeNotNull('no', instance.norwegian);
  writeNotNull('fa', instance.persian);
  writeNotNull('pl', instance.polish);
  writeNotNull('pt', instance.portuguese);
  writeNotNull('pt-br', instance.portugueseBr);
  writeNotNull('ro', instance.romanian);
  writeNotNull('ru', instance.russian);
  writeNotNull('sr', instance.serbian);
  writeNotNull('es', instance.spanish);
  writeNotNull('es-la', instance.spanishLATAM);
  writeNotNull('sv', instance.swedish);
  writeNotNull('th', instance.thai);
  writeNotNull('tr', instance.turkish);
  writeNotNull('uk', instance.ukrainian);
  writeNotNull('vi', instance.vietnamese);
  return val;
}
