import 'package:komikku/data/hive.dart';
import 'package:komikku/dex/models/attributes/cover_attributes.dart';
import 'package:komikku/dex/models/enum/content_rating.dart';
import 'package:komikku/dex/models/enum/entity_type.dart';
import 'package:komikku/dex/models/enum/status.dart';
import 'package:komikku/dex/models/manga.dart';
import 'package:komikku/dex/models/relationship.dart';
import 'package:komikku/dex/retrieving.dart';

import '../dex/models/attributes/author_attributes.dart';

/// 漫画
class MangaDto {
  final String id;
  final String title;
  final String status;
  final String author;
  final List<String> tags;
  final String imageUrl256;
  final String imageUrl512;
  final String imageUrlOriginal;
  final String contentRating;
  final String? description;

  MangaDto({
    required this.id,
    required this.title,
    required this.status,
    required this.author,
    required this.tags,
    required this.imageUrl256,
    required this.imageUrl512,
    required this.imageUrlOriginal,
    required this.contentRating,
    this.description,
  });

  factory MangaDto.fromDex(Manga source) {
    /// NOTE: 必须含有 CoverAttributes AuthorAttributes
    final coverAttributes =
        CoverAttributes.fromJson(source.relationships.firstType(EntityType.coverArt).attributes);
    final authorAttributes =
        AuthorAttributes.fromJson(source.relationships.firstType(EntityType.author).attributes);

    var titleMap = source.attributes.title.toJson();
    var title = titleMap.values.first;
    var altTitleMapList = source.attributes.altTitles?.map((e) => e.toJson());
    if (altTitleMapList != null) {
      for (var map in altTitleMapList) {
        titleMap.addAll(map);
      }
    }

    for (var entry in titleMap.entries) {
      if (!HiveDatabase.translatedLanguage.contains(entry.key)) continue;
      title = entry.value;
    }

    String? description;
    if (source.attributes.description != null) {
      for (var entry in source.attributes.description!.toJson().entries) {
        if (!HiveDatabase.translatedLanguage.contains(entry.key)) continue;
        description = entry.value;
      }
    }

    var tags = <String>[];
    for (var tag in source.attributes.tags) {
      var nameMap = tag.attributes.name.toJson();
      var name = nameMap.values.first;
      for (var entry in nameMap.entries) {
        if (!HiveDatabase.translatedLanguage.contains(entry.key)) continue;
        name = entry.value;
      }

      tags.add(name);
    }

    return MangaDto(
      id: source.id,
      title: title,
      status: _statusEnumChineseMap[source.attributes.status]!,
      author: authorAttributes.name,
      tags: tags,
      imageUrl256: Retrieving.getCoverArtOn256(source.id, coverAttributes.fileName),
      imageUrl512: Retrieving.getCoverArtOn512(source.id, coverAttributes.fileName),
      imageUrlOriginal: Retrieving.getCoverArtOnOriginal(source.id, coverAttributes.fileName),
      contentRating: _contentRatingEnumMap[source.attributes.contentRating]!,
      description: description,
    );
  }

  static const _contentRatingEnumMap = {
    ContentRating.safe: 'safe',
    ContentRating.suggestive: 'suggestive',
    ContentRating.erotica: 'erotica',
    ContentRating.pornographic: 'pornographic',
  };

  static const _statusEnumChineseMap = {
    Status.ongoing: '正在连载',
    Status.completed: '已完结',
    Status.hiatus: '暂停连载',
    Status.cancelled: '取消连载',
  };
}
