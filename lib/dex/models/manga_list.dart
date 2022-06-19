import 'package:json_annotation/json_annotation.dart';
import 'enum/response_type.dart';
import 'manga.dart';
import 'response.dart';

part 'manga_list.g.dart';

/// Manga list response.
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
