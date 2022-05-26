import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komikku/dto/manga_dto.dart';

/// Manga ListView Item
class MangaListViewItem extends StatelessWidget {
  const MangaListViewItem({Key? key, required this.dto}) : super(key: key);
  final MangaDto dto;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: dto.imageUrl256,
              fit: BoxFit.fitWidth,
              width: 70,
              errorWidget: (context, url, progress) =>
                  Image.asset('assets/images/image-failed.png'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 2, 2, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      dto.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Text(dto.status, style: const TextStyle(fontSize: 13, color: Colors.black45)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
