import 'package:komikku/dex/models.dart';
import 'package:komikku/dex/models/attributes/scanlation_group_attributes.dart';
import 'package:komikku/dex/models/attributes/user_attributes.dart';

class ChapterDto {
  String id;
  DateTime publishAt;
  String uploader;
  String? scanlationGroup;
  String? title;
  String? chapter;
  String? volume;

  ChapterDto({
    required this.id,
    required this.publishAt,
    required this.uploader,
    this.scanlationGroup,
    this.title,
    this.chapter,
    this.volume,
  });

  factory ChapterDto.fromSource(Chapter source) {
    /// NOTE: 必须含有 ScanlationAttributes UserAttributes
    /// NOTE: 此处可能出出现没有scanlationGroup返回的情况
    var map = source.relationships.firstTypeOrDefault(EntityType.scanlationGroup)?.attributes;
    var scanlationAttributes = map == null ? null : ScanlationGroupAttributes.fromJson(map);
    var userAttributes =
        UserAttributes.fromJson(source.relationships.firstType(EntityType.user).attributes);

    return ChapterDto(
      id: source.id,
      title: source.attributes.title,
      chapter: source.attributes.chapter,
      volume: source.attributes.volume,
      publishAt: DateTime.parse(source.attributes.publishAt),
      uploader: userAttributes.username,
      scanlationGroup: scanlationAttributes?.name,
    );
  }
}
