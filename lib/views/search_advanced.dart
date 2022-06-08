part of 'search.dart';

/// 高级搜索
class AdvancedSearch extends StatelessWidget {
  const AdvancedSearch({
    Key? key,
    required this.tags,
    required this.onChanged,
    required this.selected,
  }) : super(key: key);

  final List<TagDto> tags;
  final void Function(bool, TagDto) onChanged;
  final bool Function(String) selected;

  @override
  Widget build(BuildContext context) {
    var grouped = tags.groupListsBy((value) => value.group);
    var children = <Widget>[];
    grouped.forEach((key, value) {
      var child = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(key),
        ManyChoiceChipWarp(
          values: value.map((e) => e.name).toList(),
          selected: (value) => selected(value),
          onChanged: (flag, value) => onChanged(flag, tags.firstWhere((e) => e.name == value)),
        ),
      ]);

      children.add(child);
    });
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }
}
