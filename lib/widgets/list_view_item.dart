import 'package:flutter/material.dart';
import 'package:komikku/utils/timeago.dart';

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
