class AtHomeChapter {
  String hash;
  List<String> data;
  List<String> dataSaver;

  AtHomeChapter({
    required this.hash,
    required this.data,
    required this.dataSaver,
  });

  factory AtHomeChapter.fromJson(Map<String, dynamic> json) => AtHomeChapter(
        hash: json['hash'] as String,
        data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
        dataSaver: (json['dataSaver'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'hash': hash,
        'data': data,
        'dataSaver': dataSaver,
      };
}
