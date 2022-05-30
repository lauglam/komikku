import 'package:komikku/dex/models/attributes/cover_attributes.dart';
import 'package:komikku/dex/models/enum/entity_type.dart';
import 'package:komikku/dex/models/enum/status.dart';
import 'package:komikku/dex/models/manga.dart';
import 'package:komikku/dex/models/relationship.dart';
import 'package:komikku/dex/retrieving.dart';
import 'package:komikku/dto/tag_dto.dart';

import '../dex/models/attributes/author_attributes.dart';

/// 漫画
class MangaDto {
  final String id;
  final String title;
  final String status;
  final String author;
  final List<TagDto> tags;
  final String imageUrl256;
  final String imageUrl512;
  final String imageUrlOriginal;
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
    this.description,
  });

  factory MangaDto.fromSource(Manga source) {
    /// NOTE: 必须含有 CoverAttributes AuthorAttributes
    var coverAttributes =
        CoverAttributes.fromJson(source.relationships.firstType(EntityType.coverArt).attributes);
    var authorAttributes =
        AuthorAttributes.fromJson(source.relationships.firstType(EntityType.author).attributes);

    return MangaDto(
      id: source.id,
      title: source.attributes.title.value(),
      status: statusEnumChineseMap[source.attributes.status]!,
      author: authorAttributes.name,
      tags: source.attributes.tags.map((e) => TagDto.fromSource(e)).toList(),
      imageUrl256: Retrieving.getCoverArtOn256(source.id, coverAttributes.fileName),
      imageUrl512: Retrieving.getCoverArtOn512(source.id, coverAttributes.fileName),
      imageUrlOriginal: Retrieving.getCoverArtOnOriginal(source.id, coverAttributes.fileName),
      description: source.attributes.description?.value(),
    );
  }

  factory MangaDto.fromJson(Map<String, dynamic> json) => MangaDto(
        id: json['id'] as String,
        title: json['title'] as String,
        status: json['status'] as String,
        author: json['author'] as String,
        tags: (json['tags'] as List<dynamic>)
            .map((e) => TagDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        imageUrl256: json['imageUrl256'] as String,
        imageUrl512: json['imageUrl512'] as String,
        imageUrlOriginal: json['imageUrlOriginal'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'status': status,
        'author': author,
        'tags': tags,
        'imageUrl256': imageUrl256,
        'imageUrl512': imageUrl512,
        'imageUrlOriginal': imageUrlOriginal,
      };
}
