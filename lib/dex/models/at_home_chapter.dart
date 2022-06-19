import 'package:json_annotation/json_annotation.dart';

part 'at_home_chapter.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AtHomeChapter {
  /// The hash code.
  final String hash;

  /// The image file name list of chapter.
  final List<String> data;

  /// The data saver image file name list of chapter.
  final List<String> dataSaver;

  AtHomeChapter({
    required this.hash,
    required this.data,
    required this.dataSaver,
  });

  factory AtHomeChapter.fromJson(Map<String, dynamic> json) => _$AtHomeChapterFromJson(json);

  Map<String, dynamic> toJson() => _$AtHomeChapterToJson(this);
}
