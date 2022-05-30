import 'package:komikku/dex/models.dart';
import 'package:komikku/dex/models/attributes/scanlation_group_attributes.dart';
import 'package:komikku/dex/models/attributes/user_attributes.dart';

class ChapterDto {
  String id;
  DateTime readableAt;
  String? uploader;
  String? scanlationGroup;
  String? title;
  String? chapter;
  String? volume;

  ChapterDto({
    required this.id,
    required this.readableAt,
    this.uploader,
    this.scanlationGroup,
    this.title,
    this.chapter,
    this.volume,
  });

  factory ChapterDto.fromSource(Chapter source) {
    /// NOTE: 必须含有 ScanlationAttributes UserAttributes
    /// NOTE: 此处可能出出现没有返回的情况
    var groupMap = source.relationships.firstTypeOrDefault(EntityType.scanlationGroup)?.attributes;
    var userMap = source.relationships.firstTypeOrDefault(EntityType.user)?.attributes;

    var groupAttributes = groupMap == null ? null : ScanlationGroupAttributes.fromJson(groupMap);
    var userAttributes = userMap == null ? null : UserAttributes.fromJson(userMap);

    return ChapterDto(
      id: source.id,
      title: source.attributes.title,
      chapter: source.attributes.chapter,
      volume: source.attributes.volume,
      readableAt: DateTime.parse(source.attributes.readableAt),
      uploader: userAttributes?.username,
      scanlationGroup: groupAttributes?.name,
    );
  }
}
