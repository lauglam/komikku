import 'package:json_annotation/json_annotation.dart';

part 'at_home_chapter.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AtHomeChapter {
  /// 哈希值
  final String hash;

  /// 图片名称列表
  final List<String> data;

  /// 压缩质量图片名称列表
  final List<String> dataSaver;

  AtHomeChapter({
    required this.hash,
    required this.data,
    required this.dataSaver,
  });

  factory AtHomeChapter.fromJson(Map<String, dynamic> json) => _$AtHomeChapterFromJson(json);

  Map<String, dynamic> toJson() => _$AtHomeChapterToJson(this);
}
