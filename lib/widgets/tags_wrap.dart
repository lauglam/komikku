import 'package:flutter/material.dart';

class TagsWarp extends StatelessWidget {
  const TagsWarp({Key? key, required this.tags}) : super(key: key);
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: -10,
      children: tags
          .map((tag) => Chip(
                padding: const EdgeInsets.all(0),
                labelPadding: const EdgeInsets.fromLTRB(8, -2, 8, -2),
                visualDensity: VisualDensity.compact,
                label: Text(tag, style: const TextStyle(fontSize: 10)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ))
          .toList(),
    );
  }
}
