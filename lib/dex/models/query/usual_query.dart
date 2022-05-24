class UsualQuery {
  List<String>? includes;
  int? limit;
  int? offset;

  UsualQuery({
    this.includes,
    this.limit,
    this.offset,
  });

  factory UsualQuery.fromJson(Map<String, dynamic> json) => UsualQuery(
        limit: json['limit'] as int?,
        offset: json['offset'] as int?,
        includes: (json['includes[]'] as List<dynamic>?)?.map((e) => e as String).toList(),
      );

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('limit', limit?.toString());
    writeNotNull('offset', offset?.toString());
    writeNotNull('includes[]', includes);
    return val;
  }
}
