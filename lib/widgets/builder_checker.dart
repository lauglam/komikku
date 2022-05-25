import 'package:flutter/material.dart';

typedef WidgetCallback = Widget Function();

/// Builder Checker
class BuilderChecker<T> extends StatelessWidget {
  const BuilderChecker({
    Key? key,
    required this.snapshot,
    required this.widget,
    this.indicator = true,
  }) : super(key: key);

  final AsyncSnapshot<T> snapshot;
  final WidgetCallback widget;
  final bool indicator;

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return const Center(child: Text('无数据'));
      case ConnectionState.waiting:
        return Offstage(
          offstage: !indicator,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      default:
        if (snapshot.hasError) {
          return Center(child: Text('出现错误$snapshot.error}'));
        }
        return widget();
    }
  }
}
