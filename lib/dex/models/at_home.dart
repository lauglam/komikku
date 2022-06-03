import 'package:komikku/dex/models/at_home_chapter.dart';

class AtHome {
  final String baseUrl;
  final AtHomeChapter chapter;

  AtHome({
    required this.baseUrl,
    required this.chapter,
  });

  factory AtHome.fromJson(Map<String, dynamic> json) => AtHome(
        baseUrl: json['baseUrl'] as String,
        chapter:
            AtHomeChapter.fromJson(json['chapter'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'baseUrl': baseUrl,
        'chapter': chapter.toJson(),
      };
}
