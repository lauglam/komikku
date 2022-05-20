class ChapterAttributes {
  String title;
  String publishAt;
  String readableAt;
  String translatedLanguage;
  int pages;
  String? uploader;
  String? volume;
  String? chapter;
  String? externalUrl;

  ChapterAttributes({
    required this.title,
    required this.publishAt,
    required this.readableAt,
    required this.translatedLanguage,
    required this.pages,
    this.uploader,
    this.volume,
    this.chapter,
    this.externalUrl,
  });

  factory ChapterAttributes.fromJson(Map<String, dynamic> json) =>
      ChapterAttributes(
        title: json['title'] as String,
        publishAt: json['publishAt'] as String,
        readableAt: json['readableAt'] as String,
        uploader: json['uploader'] as String?,
        translatedLanguage: json['translatedLanguage'] as String,
        pages: json['pages'] as int,
        volume: json['volume'] as String?,
        chapter: json['chapter'] as String?,
        externalUrl: json['externalUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'publishAt': publishAt,
        'readableAt': readableAt,
        'uploader': uploader,
        'translatedLanguage': translatedLanguage,
        'pages': pages,
        'volume': volume,
        'chapter': chapter,
        'externalUrl': externalUrl,
      };
}
