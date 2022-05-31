import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komikku/utils/timeago.dart';

/// List View Item
class ListViewItem extends StatelessWidget {
  const ListViewItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.date,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
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
              child: Text(timeAgo(date)),
            ),
            Text(subtitle),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_rounded),
      ),
    );
  }
}

/// Image ListView Item
class ImageListViewItem extends StatelessWidget {
  const ImageListViewItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fill,
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
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.black45)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
