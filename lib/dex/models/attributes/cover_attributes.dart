class CoverAttributes {
  final String fileName;
  final String? volume;
  final String? description;
  final String? locale;

  CoverAttributes({
    required this.fileName,
    this.volume,
    this.description,
    this.locale,
  });

  factory CoverAttributes.fromJson(Map<String, dynamic> json) =>
      CoverAttributes(
        fileName: json['fileName'] as String,
        volume: json['volume'] as String?,
        description: json['description'] as String?,
        locale: json['locale'] as String?,
      );

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    val['fileName'] = fileName;
    writeNotNull('volume', volume);
    writeNotNull('biography', description);
    writeNotNull('locale', locale);
    return val;
  }
}
