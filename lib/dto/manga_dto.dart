import 'package:komikku/dex/models/attributes/cover_attributes.dart';
import 'package:komikku/dex/models/enum/entity_type.dart';
import 'package:komikku/dex/models/enum/status.dart';
import 'package:komikku/dex/models/manga.dart';
import 'package:komikku/dex/models/relationship.dart';
import 'package:komikku/dex/retrieving.dart';

/// 漫画
class MangaDto {
  final String assetUrl;
  final String title;
  final String subtitle;

  MangaDto({
    required this.assetUrl,
    required this.title,
    required this.subtitle,
  });

  factory MangaDto.fromSource(Manga source) {
    /// NOTE: 必须含有 CoverAttributes
    var coverAttribute = CoverAttributes.fromJson(
        source.relationships.firstType(EntityType.coverArt).attributes);

    return MangaDto(
      title: source.attributes.title.value(),
      subtitle: '[${statusEnumChineseMap[source.attributes.status]}]',
      assetUrl: Retrieving.getCoverArtOn256(source.id, coverAttribute.fileName),
    );
  }
}
