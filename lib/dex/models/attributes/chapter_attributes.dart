class ChapterAttributes {
  final String publishAt;
  final String readableAt;
  final String translatedLanguage;
  final int pages;
  final String? title;
  final String? uploader;
  final String? volume;
  final String? chapter;
  final String? externalUrl;

  final String createdAt;
  final String updatedAt;
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

    void writeNotNull(final String key, dynamic value) {
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
    val['pages'] = pages;
    writeNotNull('title', title);
    writeNotNull('uploader', uploader);
    writeNotNull('volume', volume);
    writeNotNull('chapter', chapter);
    writeNotNull('externalUrl', externalUrl);
    return val;
  }
}
