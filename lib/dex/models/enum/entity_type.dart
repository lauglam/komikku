import 'package:json_annotation/json_annotation.dart';

enum EntityType {
  /// Manga resource.
  manga,

  /// Tag resource.
  tag,

  /// A Cover Art for a manga.
  @JsonValue('cover_art')
  coverArt,

  /// Chapter resource.
  chapter,

  /// ScanlationGroup resource.
  @JsonValue('scanlation_group')
  scanlationGroup,

  /// User resource.
  user,

  /// Custom list resource.
  @JsonValue('custom_list')
  customList,

  /// Author resource.
  author,

  /// Artist resource (drawers only).
  artist,

  /// Mapping id resource.
  @JsonValue('mapping_id')
  mappingId,

  /// Manga relation resource.
  @JsonValue('manga_relation')
  mangaRelation,

  /// Upload session resource.
  @JsonValue('upload_session')
  uploadSession,

  /// Upload session file.
  @JsonValue('upload_session_file')
  uploadSessionFile,

  /// Report resource.
  report,
}
