import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:komikku/dto/tag_dto.dart';
import 'package:komikku/widgets/chip.dart' as chip;

class AdvancedSearch extends StatelessWidget {
  const AdvancedSearch({
    Key? key,
    required this.dtos,
    required this.onChanged,
    required this.selected,
  }) : super(key: key);

  final List<TagDto> dtos;
  final chip.ValueChanged onChanged;
  final chip.BooleanCallback selected;

  @override
  Widget build(BuildContext context) {
    var grouped = dtos.groupListsBy((element) => element.group);
    var children = <Widget>[];
    grouped.forEach((key, value) {
      var child = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(key),
        chip.ManyChoiceChipWarp(
          values: value.map((e) => e.name).toList(),
          selected: (value) => selected(value),
          onChanged: (flag, value) => onChanged(flag, value),
        ),
      ]);

      children.add(child);
    });
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
  }
}
