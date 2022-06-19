import 'package:flutter/material.dart';

import '../model.dart';

class EntryItemWidget extends StatelessWidget {
  final Entry entry;

  const EntryItemWidget(this.entry, {Key? key}) : super(key: key);

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
