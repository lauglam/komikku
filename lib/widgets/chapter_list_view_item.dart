import 'package:flutter/material.dart';
import 'package:komikku/dto/chapter_dto.dart';
import 'package:komikku/utils/helper.dart';

class ChapterListViewItem extends StatelessWidget {
  const ChapterListViewItem({Key? key, required this.dto, required this.imageUrl})
      : super(key: key);
  final ChapterDto dto;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final title = dto.chapter?.isEmpty ?? true
        ? dto.title?.isEmpty ?? true
            ? '无标题'
            : '${dto.title}'
        : dto.title?.isEmpty ?? true
            ? '${dto.chapter} 无标题'
            : '${dto.chapter} ${dto.title!}';

    return Card(
      elevation: 0.5,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(RelativeDateFormat.format(dto.publishAt)),
            ),
            Text(dto.uploader),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_rounded),
      ),
    );
  }
}
