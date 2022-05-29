import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/enum/response_type.dart';
import 'package:komikku/dex/models/manga.dart';
import 'package:komikku/dex/models/response.dart';

class MangaListResponse extends PageResponse<Manga> {
  MangaListResponse({
    required super.response,
    required super.data,
    required super.limit,
    required super.offset,
    required super.total,
  });

  factory MangaListResponse.fromJson(Map<String, dynamic> json) =>
      MangaListResponse(
        response: $enumDecode(responseTypeEnumMap, json['response']),
        data: (json['data'] as List<dynamic>)
            .map((e) => Manga.fromJson(e as Map<String, dynamic>))
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
