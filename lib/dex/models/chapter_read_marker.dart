import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/enum/result.dart';
import 'package:komikku/dex/models/response.dart';

/// 漫画阅读记录响应
class ChapterReadMarkerResponse extends Response {
  ChapterReadMarkerResponse({required super.result, required this.data});

  List<String> data;

  factory ChapterReadMarkerResponse.fromJson(Map<String, dynamic> json) =>
      ChapterReadMarkerResponse(
        result: $enumDecode(resultEnumMap, json['result']),
        data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
      );

  @override
  Map<String, dynamic> toJson() => {
        'result': resultEnumMap[result],
        'data': data,
      };
}

/// 分组漫画阅读记录响应
class GroupedChapterReadMarkerResponse extends Response {
  GroupedChapterReadMarkerResponse({required super.result, required this.data});

  Map<String, List<String>> data;

  factory GroupedChapterReadMarkerResponse.fromJson(Map<String, dynamic> json) =>
      GroupedChapterReadMarkerResponse(
        result: $enumDecode(resultEnumMap, json['result']),
        data: (json['data'] as Map<String, List<dynamic>>)
            .map((key, value) => MapEntry(key, value.map((e) => e as String).toList())),
      );

  @override
  Map<String, dynamic> toJson() => {
        'result': resultEnumMap[result],
        'data': data,
      };
}

/// 批量上传阅读记录
class ChapterReadMarkerBatch {
  List<String>? chapterIdsRead;
  List<String>? chapterIdsUnread;

  ChapterReadMarkerBatch({this.chapterIdsRead, this.chapterIdsUnread});

  factory ChapterReadMarkerBatch.fromJson(Map<String, dynamic> json) => ChapterReadMarkerBatch(
        chapterIdsRead: (json['chapterIdsRead'] as List<dynamic>).map((e) => e as String).toList(),
        chapterIdsUnread:
            (json['chapterIdsUnread'] as List<dynamic>).map((e) => e as String).toList(),
      );

  Map<String, dynamic> toJson() {
    // 至少一个不为空
    if (chapterIdsRead == null && chapterIdsUnread == null) {
      throw NullThrownError();
    }

    final val = <String, dynamic>{};
    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    writeNotNull('chapterIdsRead', chapterIdsRead);
    writeNotNull('chapterIdsUnread', chapterIdsUnread);
    return val;
  }
}
