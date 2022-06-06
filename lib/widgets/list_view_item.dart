import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// ListView Item
class ListViewItem extends StatelessWidget {
  const ListViewItem({
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
              width: 75,
              height: 120,
              errorWidget: (context, url, progress) =>
                  Image.asset('assets/images/image-failed.png'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 2, 2, 2),
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
