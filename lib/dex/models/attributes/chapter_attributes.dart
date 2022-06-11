import 'package:json_annotation/json_annotation.dart';

part 'chapter_attributes.g.dart';

/// 章节属性
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ChapterAttributes {
  /// 发布时间
  final String publishAt;

  /// 可阅读时间
  final String readableAt;

  /// 翻译语言
  final String translatedLanguage;

  /// 页数
  final int pages;

  /// 标题
  final String? title;

  /// 上传者
  final String? uploader;

  /// 所属卷
  final String? volume;

  /// 章节
  final String? chapter;

  /// 额外链接
  final String? externalUrl;

  /// 创建时间
  final String createdAt;

  /// 更新时间
  final String updatedAt;

  /// 版本
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
