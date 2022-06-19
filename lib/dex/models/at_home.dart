import 'package:json_annotation/json_annotation.dart';
import 'at_home_chapter.dart';

part 'at_home.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AtHome {
  /// The server url.
  final String baseUrl;

  /// The data of chapter.
  final AtHomeChapter chapter;

  AtHome({
    required this.baseUrl,
    required this.chapter,
  });

  factory AtHome.fromJson(Map<String, dynamic> json) => _$AtHomeFromJson(json);

  Map<String, dynamic> toJson() => _$AtHomeToJson(this);
}
