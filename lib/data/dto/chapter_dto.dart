import '../../dex/models.dart';

class ChapterDto {
  final String id;
  final DateTime readableAt;
  final String? uploader;
  final String? scanlationGroup;
  final String? title;
  final String? chapter;
  final String? volume;
  final int pages;

  ChapterDto({
    required this.id,
    required this.readableAt,
    required this.pages,
    this.uploader,
    this.scanlationGroup,
    this.title,
    this.chapter,
    this.volume,
  });

  factory ChapterDto.fromDex(Chapter source) {
    /// NOTE: must contain [ScanlationAttributes] and [UserAttributes].
    /// NOTE: There may be cases where there is no return.
    final groupMap = source.relationships
        .firstTypeOrDefault(EntityType.scanlationGroup)
        ?.attributes;
    final userMap =
        source.relationships.firstTypeOrDefault(EntityType.user)?.attributes;

    final groupAttributes =
        groupMap == null ? null : ScanlationGroupAttributes.fromJson(groupMap);
    final userAttributes =
        userMap == null ? null : UserAttributes.fromJson(userMap);

    return ChapterDto(
      id: source.id,
      title: source.attributes.title,
      chapter: source.attributes.chapter,
      volume: source.attributes.volume,
      readableAt: DateTime.parse(source.attributes.readableAt),
      uploader: userAttributes?.username,
      scanlationGroup: groupAttributes?.name,
      pages: source.attributes.pages,
    );
  }
}
