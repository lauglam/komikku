import 'package:flutter/material.dart';
import 'package:komikku/utils/icons.dart';

typedef BooleanCallback = bool Function(String);
typedef ValueChanged = void Function(bool, String);

/// 普通的 Chip
class ChipWarp extends StatelessWidget {
  const ChipWarp(this.values, {Key? key}) : super(key: key);
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (var value in values) {
      var child = Chip(
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.fromLTRB(8, -2, 8, -2),
        visualDensity: VisualDensity.compact,
        label: Text(value, style: const TextStyle(fontSize: 10)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      );
      children.add(child);
    }

    return Wrap(spacing: 6, runSpacing: -10, children: children);
  }
}

/// 可以删除的Chip
class CanDeleteChipWarp extends StatefulWidget {
  const CanDeleteChipWarp({
    Key? key,
    required this.values,
    required this.onDeleted,
  }) : super(key: key);

  final List<String> values;
  final ValueSetter<String> onDeleted;

  @override
  State<CanDeleteChipWarp> createState() => _CanDeleteChipWarpState();
}

class _CanDeleteChipWarpState extends State<CanDeleteChipWarp> {
  @override
  Widget build(BuildContext context) {
    var children = List.generate(
      widget.values.length,
      (index) => Chip(
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.fromLTRB(8, -2, 8, -2),
        visualDensity: VisualDensity.compact,
        label: Text(widget.values[index], style: const TextStyle(fontSize: 10)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        deleteIcon: Transform.scale(
          scale: 0.7,
          child: const Icon(TaoIcons.trash),
        ),
        deleteIconColor: Colors.red,
        onDeleted: () => setState(() => widget.onDeleted.call(widget.values[index])),
      ),
    );

    return Wrap(spacing: 6, runSpacing: -10, children: children);
  }
}

/// 可以单选的Chip
class SingleChoiceChipWarp extends StatefulWidget {
  const SingleChoiceChipWarp({
    Key? key,
    required this.values,
    required this.onChanged,
  }) : super(key: key);

  final List<String> values;
  final ValueChanged onChanged;

  @override
  State<SingleChoiceChipWarp> createState() => _SingleChoiceChipWarpState();
}

class _SingleChoiceChipWarpState extends State<SingleChoiceChipWarp> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var children = List.generate(
      widget.values.length,
      (index) => ChoiceChip(
        selectedColor: Theme.of(context).primaryColor,
        selected: _selectedIndex == index,
        onSelected: (value) => setState(() {
          _selectedIndex = index;
          widget.onChanged(value, widget.values[index]);
        }),
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.fromLTRB(8, -2, 8, -2),
        visualDensity: VisualDensity.compact,
        label: Text(widget.values[index], style: const TextStyle(fontSize: 10)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );

    return Wrap(spacing: 6, runSpacing: -10, children: children);
  }
}

/// 多选 Chip
class ManyChoiceChipWarp extends StatefulWidget {
  const ManyChoiceChipWarp({
    Key? key,
    required this.values,
    required this.onChanged,
    required this.selected,
  }) : super(key: key);

  final List<String> values;
  final ValueChanged onChanged;
  final BooleanCallback selected;

  @override
  State<ManyChoiceChipWarp> createState() => _ManyChoiceChipWrapState();
}

class _ManyChoiceChipWrapState extends State<ManyChoiceChipWarp> {
  @override
  Widget build(BuildContext context) {
    var children = List.generate(
      widget.values.length,
      (index) => ChoiceChip(
        selectedColor: Theme.of(context).primaryColor,
        selected: widget.selected(widget.values[index]),
        onSelected: (value) => setState(() => widget.onChanged(value, widget.values[index])),
        padding: const EdgeInsets.all(0),
        labelPadding: const EdgeInsets.fromLTRB(8, -2, 8, -2),
        visualDensity: VisualDensity.compact,
        label: Text(widget.values[index], style: const TextStyle(fontSize: 10)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );

    return Wrap(spacing: 6, runSpacing: -10, children: children);
  }
}
