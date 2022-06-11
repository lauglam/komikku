import 'package:json_annotation/json_annotation.dart';

part 'localized_string.g.dart';

/// 多语言
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocalizedString {
  /// 英语
  @JsonKey(name: 'en')
  final String? english;

  /// 阿拉伯语
  @JsonKey(name: 'ar')
  final String? arabic;

  /// 孟加拉语
  @JsonKey(name: 'bn')
  final String? bengali;

  /// 保加利亚语
  @JsonKey(name: 'bg')
  final String? bulgarian;

  /// 缅甸语
  @JsonKey(name: 'my')
  final String? burmese;

  /// 加泰隆语
  @JsonKey(name: 'ca')
  final String? catalan;

  /// 简体汉语
  @JsonKey(name: 'zh')
  final String? chineseSimplified;

  /// 繁体汉语
  @JsonKey(name: 'zh-hk')
  final String? chineseTraditional;

  /// 罗马-汉语
  @JsonKey(name: 'zh-ro')
  final String? chineseRoman;

  /// 克罗埃西亚语
  @JsonKey(name: 'hr')
  final String? croatian;

  /// 捷克语
  @JsonKey(name: 'cs')
  final String? czech;

  /// 丹麦语
  @JsonKey(name: 'da')
  final String? danish;

  /// 荷兰语
  @JsonKey(name: 'nl')
  final String? dutch;

  /// 世界语（人工语言）
  @JsonKey(name: 'eo')
  final String? esperanto;

  /// 爱沙尼亚语
  @JsonKey(name: 'et')
  final String? estonian;

  /// 菲律宾语
  @JsonKey(name: 'tl')
  final String? filipino;

  /// 芬兰语
  @JsonKey(name: 'fi')
  final String? finnish;

  /// 法语
  @JsonKey(name: 'fr')
  final String? french;

  /// 德语
  @JsonKey(name: 'de')
  final String? german;

  /// 希腊语
  @JsonKey(name: 'el')
  final String? greek;

  /// 希伯来语
  @JsonKey(name: 'he')
  final String? hebrew;

  /// 印地语
  @JsonKey(name: 'hi')
  final String? hindi;

  /// 匈牙利语
  @JsonKey(name: 'hu')
  final String? hungarian;

  /// 印尼语
  @JsonKey(name: 'id')
  final String? indonesian;

  /// 意大利语
  @JsonKey(name: 'it')
  final String? italian;

  /// 日语
  @JsonKey(name: 'ja')
  final String? japanese;

  /// 罗马-日语
  @JsonKey(name: 'ja-ro')
  final String? japaneseRoman;

  /// 韩语
  @JsonKey(name: 'ko')
  final String? korean;

  /// 罗马-韩语
  @JsonKey(name: 'ko-ro')
  final String? koreanRoman;

  /// 拉丁语
  @JsonKey(name: 'la')
  final String? latin;

  /// 立陶宛语
  @JsonKey(name: 'lt')
  final String? lithuanian;

  /// 马来语
  @JsonKey(name: 'ms')
  final String? malay;

  /// 蒙古语
  @JsonKey(name: 'mn')
  final String? mongolian;

  /// 尼泊尔语
  @JsonKey(name: 'ne')
  final String? nepali;

  /// 挪威语
  @JsonKey(name: 'no')
  final String? norwegian;

  /// 波斯语
  @JsonKey(name: 'fa')
  final String? persian;

  /// 波兰语
  @JsonKey(name: 'pl')
  final String? polish;

  /// 葡萄牙语
  @JsonKey(name: 'pt')
  final String? portuguese;

  /// 巴西-葡萄牙语
  @JsonKey(name: 'pt-br')
  final String? portugueseBr;

  /// 罗马尼亚语
  @JsonKey(name: 'ro')
  final String? romanian;

  /// 俄语
  @JsonKey(name: 'ru')
  final String? russian;

  /// 塞尔维亚语
  @JsonKey(name: 'sr')
  final String? serbian;

  /// 西班牙语
  @JsonKey(name: 'es')
  final String? spanish;

  /// 拉丁美洲-西班牙语
  @JsonKey(name: 'es-la')
  final String? spanishLATAM;

  /// 瑞典语
  @JsonKey(name: 'sv')
  final String? swedish;

  /// 泰语
  @JsonKey(name: 'th')
  final String? thai;

  /// 土耳其语
  @JsonKey(name: 'tr')
  final String? turkish;

  /// 乌克兰语
  @JsonKey(name: 'uk')
  final String? ukrainian;

  /// 越南语
  @JsonKey(name: 'vi')
  final String? vietnamese;

  LocalizedString({
    this.english,
    this.arabic,
    this.bengali,
    this.bulgarian,
    this.burmese,
    this.catalan,
    this.chineseSimplified,
    this.chineseTraditional,
    this.chineseRoman,
    this.croatian,
    this.czech,
    this.danish,
    this.dutch,
    this.esperanto,
    this.estonian,
    this.filipino,
    this.finnish,
    this.french,
    this.german,
    this.greek,
    this.hebrew,
    this.hindi,
    this.hungarian,
    this.indonesian,
    this.italian,
    this.japanese,
    this.japaneseRoman,
    this.korean,
    this.koreanRoman,
    this.latin,
    this.lithuanian,
    this.malay,
    this.mongolian,
    this.nepali,
    this.norwegian,
    this.persian,
    this.polish,
    this.portuguese,
    this.portugueseBr,
    this.romanian,
    this.russian,
    this.serbian,
    this.spanish,
    this.spanishLATAM,
    this.swedish,
    this.thai,
    this.turkish,
    this.ukrainian,
    this.vietnamese,
  });

  factory LocalizedString.fromJson(Map<String, dynamic> json) => _$LocalizedStringFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizedStringToJson(this);
}

/// 某些值会出现以下情况：
/// 1. []
/// 2. Object
/// 当值为第1种情况时，为空数组，此时返回null即可
/// 当值为第2种情况时，按照正常返回即可
Object? readSingleOrArray(Map json, String key) {
  final childValue = json[key];

  if (childValue is Iterable) return null;
  return childValue;
}
