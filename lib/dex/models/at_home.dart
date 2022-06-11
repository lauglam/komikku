import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/at_home_chapter.dart';

part 'at_home.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AtHome {
  /// 服务器地址
  final String baseUrl;

  /// 章节数据
  final AtHomeChapter chapter;

  AtHome({
    required this.baseUrl,
    required this.chapter,
  });

  factory AtHome.fromJson(Map<String, dynamic> json) => _$AtHomeFromJson(json);

  Map<String, dynamic> toJson() => _$AtHomeToJson(this);
}
