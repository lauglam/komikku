import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/localized_string.dart';

part 'scanlation_group_attributes.g.dart';

/// 扫描组属性
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScanlationGroupAttributes {
  /// 扫描组名称
  final String name;

  /// 是否锁定
  final bool locked;

  /// 是否是官方
  final bool official;

  /// 是否活跃
  final bool inactive;

  /// 发布延迟
  final String? publishDelay;

  /// 备用名称
  final List<LocalizedString>? altNames;

  /// 网站
  final String? website;

  /// 群里服务器
  final String? ircServer;

  /// 群聊频道
  final String? ircChannel;

  /// discord
  final String? discord;

  /// 联系邮箱
  final String? contactEmail;

  /// 描述
  final String? description;

  /// twitter
  final String? twitter;

  /// 上传的漫画
  final String? mangaUpdates;

  /// 专注翻译语言
  List<String>? focusedLanguage;

  /// 创建时间
  String createdAt;

  /// 更新时间
  String updatedAt;

  /// 版本
  int version;

  ScanlationGroupAttributes({
    required this.name,
    required this.locked,
    required this.official,
    required this.inactive,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.publishDelay,
    this.altNames,
    this.website,
    this.ircServer,
    this.ircChannel,
    this.discord,
    this.contactEmail,
    this.description,
    this.twitter,
    this.mangaUpdates,
    this.focusedLanguage,
  });

  factory ScanlationGroupAttributes.fromJson(Map<String, dynamic> json) =>
      _$ScanlationGroupAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$ScanlationGroupAttributesToJson(this);
}
