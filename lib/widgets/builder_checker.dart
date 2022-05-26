import 'package:flutter/material.dart';

typedef WidgetCallback = Widget Function();

/// Builder Checker
class BuilderChecker<T> extends StatelessWidget {
  const BuilderChecker({
    Key? key,
    required this.snapshot,
    required this.child,
    this.onNone,
    this.onWaiting,
    this.onError,
    this.indicator = true,
  }) : super(key: key);

  final AsyncSnapshot<T> snapshot;
  final WidgetCallback child;
  final WidgetCallback? onNone;
  final WidgetCallback? onWaiting;
  final WidgetCallback? onError;
  final bool indicator;

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return onNone?.call() ?? const Center(child: Text('无数据'));
      case ConnectionState.waiting:
        return Offstage(
          offstage: !indicator,
          child: onWaiting?.call() ?? const Center(child: CircularProgressIndicator()),
        );
      default:
        if (snapshot.hasError) {
          return onError?.call() ?? Center(child: Text('出现错误$snapshot.error}'));
        }
        return child();
    }
  }
}
