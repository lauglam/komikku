import 'package:flutter/material.dart';

import 'indicator.dart';

/// The widget of empty.
const emptyWidget = SizedBox.shrink();

/// The indicator of default.
const defaultIndicator = ThinProgressIndicator();

/// Text of center.
class CenterText extends StatelessWidget {
  final String text;

  const CenterText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(child: Text(text));
}
