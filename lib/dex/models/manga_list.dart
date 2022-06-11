import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/enum/response_type.dart';
import 'package:komikku/dex/models/manga.dart';
import 'package:komikku/dex/models/response.dart';

part 'manga_list.g.dart';

/// 漫画列表
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MangaListResponse extends PageResponse<Manga> {
  MangaListResponse({
    required super.response,
    required super.data,
    required super.limit,
    required super.offset,
    required super.total,
  });

  factory MangaListResponse.fromJson(Map<String, dynamic> json) =>
      _$MangaListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MangaListResponseToJson(this);
}
