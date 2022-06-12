import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/localized_string.dart';
import 'package:komikku/dex/models/enum/state.dart';
import 'package:komikku/dex/models/enum/status.dart';
import 'package:komikku/dex/models/enum/content_rating.dart';
import 'package:komikku/dex/models/enum/publication_demographic.dart';
import 'package:komikku/dex/models/tag.dart';

part 'manga_attributes.g.dart';

/// 漫画属性
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MangaAttributes {
  /// 标题
  final LocalizedString title;

  /// 是否锁定
  final bool isLocked;

  /// 原始语言
  final String originalLanguage;

  /// 内容分级
  final ContentRating contentRating;

  /// 新的一卷卷时章节编号是否i重置
  final bool chapterNumbersResetOnNewVolume;

  /// 可用的章节翻译语言
  final List<String?> availableTranslatedLanguages;

  /// 标签
  final List<Tag> tags;

  /// 漫画更新状态
  final Status status;

  /// 漫画状态
  final State state;

  /// 备用标题
  final List<LocalizedString>? altTitles;

  /// 描述
  @JsonKey(readValue: readSingleOrArray)
  final LocalizedString? description;

  /// 最新卷
  final String? lastVolume;

  /// 最新章
  final String? lastChapter;

  /// 漫画类型
  final PublicationDemographic? publicationDemographic;

  /// 年份
  final int? year;

  /// 链接
  final dynamic links;

  /// 创建时间
  final String createdAt;

  /// 更新时间
  final String updatedAt;

  /// 版本
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

  factory MangaAttributes.fromJson(Map<String, dynamic> json) => _$MangaAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$MangaAttributesToJson(this);
}
