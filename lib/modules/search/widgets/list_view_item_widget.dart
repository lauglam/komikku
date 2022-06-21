import 'package:flutter/material.dart';

import '../../../widgets/image.dart';

/// 漫画搜索子项布局
class ListViewItemWidget extends StatelessWidget {
  const ListViewItemWidget({
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
    final left = ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(2),
      child: ExtendedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: 85,
        height: 130,
      ),
    );

    final right = Expanded(
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
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );

    return Container(
      height: 130,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [left, right],
      ),
    );
  }
}
