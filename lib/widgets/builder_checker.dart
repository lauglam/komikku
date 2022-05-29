import 'package:flutter/material.dart';
import 'package:komikku/utils/toast.dart';

typedef WidgetCallback = Widget Function();

/// Builder Checker
class BuilderChecker<T> extends StatelessWidget {
  const BuilderChecker({
    Key? key,
    required this.snapshot,
    required this.builder,
    this.none,
    this.waiting,
    this.error,
    this.indicator = true,
  }) : super(key: key);

  final AsyncSnapshot<T> snapshot;
  final WidgetBuilder builder;
  final Widget? none;
  final Widget? waiting;
  final Widget? error;
  final bool indicator;

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        if (none != null) return none!;
        showText(text: '无数据');
        return const SizedBox.shrink();
      case ConnectionState.waiting:
        if (waiting != null) return waiting!;
        return Offstage(
          offstage: !indicator,
          child: const Center(child: CircularProgressIndicator()),
        );
      default:
        if (snapshot.hasError) {
          if (error != null) return error!;
          showText(text: '出现错误$snapshot.error}');
          return const SizedBox.shrink();
        }
        return builder(context);
    }
  }
}
