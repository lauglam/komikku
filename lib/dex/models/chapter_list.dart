import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/chapter.dart';
import 'package:komikku/dex/models/response.dart';

import 'enum/response_type.dart';

class ChapterListResponse extends PageResponse<List<Chapter>> {
  ChapterListResponse({
    required super.response,
    required super.data,
    required super.limit,
    required super.offset,
    required super.total,
  });

  factory ChapterListResponse.fromJson(Map<String, dynamic> json) =>
      ChapterListResponse(
        response: $enumDecode(responseTypeEnumMap, json['response']),
        data: (json['data'] as List<dynamic>)
            .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
            .toList(),
        limit: json['limit'] as int,
        offset: json['offset'] as int,
        total: json['total'] as int,
      );

  Map<String, dynamic> toJson() => {
        'response': responseTypeEnumMap[response],
        'data': data,
        'limit': limit,
        'offset': offset,
        'total': total,
      };
}


