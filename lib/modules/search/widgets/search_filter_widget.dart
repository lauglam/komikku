import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

class SearchFilterWidget extends StatelessWidget {
  const SearchFilterWidget({
    Key? key,
    required this.tagsGrouped,
    required this.onChanged,
    required this.selected,
  }) : super(key: key);

  /// 标签组
  /// <group_name, <id, name>>
  final Map<String, Map<String, String>> tagsGrouped;
  final void Function(bool, MapEntry<String, String>) onChanged;
  final bool Function(String) selected;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    tagsGrouped.forEach((key, value) {
      var child = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(key, style: Theme.of(context).textTheme.titleMedium),
          ManyChoiceChipWarp(
            values: value.values.toList(),
            selected: (value) => selected(value),
            onChanged: (flag, v) {
              for (var entry in value.entries) {
                if (entry.value == v) {
                  onChanged(flag, entry);
                  return;
                }
              }
            },
          ),
        ],
      );

      children.add(child);
    });
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }
}
