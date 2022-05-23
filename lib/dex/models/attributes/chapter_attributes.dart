class ChapterAttributes {
  String publishAt;
  String readableAt;
  String translatedLanguage;
  int pages;
  String? title;
  String? uploader;
  String? volume;
  String? chapter;
  String? externalUrl;

  String createdAt;
  String updatedAt;
  int version;

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

  factory ChapterAttributes.fromJson(Map<String, dynamic> json) => ChapterAttributes(
        publishAt: json['publishAt'] as String,
        readableAt: json['readableAt'] as String,
        translatedLanguage: json['translatedLanguage'] as String,
        pages: json['pages'] as int,
        createdAt: json['createdAt'] as String,
        updatedAt: json['updatedAt'] as String,
        version: json['version'] as int,
        title: json['title'] as String?,
        uploader: json['uploader'] as String?,
        volume: json['volume'] as String?,
        chapter: json['chapter'] as String?,
        externalUrl: json['externalUrl'] as String?,
      );

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    val['publishAt'] = publishAt;
    val['readableAt'] = readableAt;
    val['translatedLanguage'] = translatedLanguage;
    val['createdAt'] = createdAt;
    val['updatedAt'] = updatedAt;
    val['version'] = version;
    writeNotNull('pages', pages);
    writeNotNull('title', title);
    writeNotNull('uploader', uploader);
    writeNotNull('volume', volume);
    writeNotNull('chapter', chapter);
    writeNotNull('externalUrl', externalUrl);
    return val;
  }
}
