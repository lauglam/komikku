import 'dart:io';

import 'package:flutter/material.dart';
import 'package:komikku/widgets/widgets.dart';

import 'indicator.dart';

typedef WidgetCallback = Widget Function();

/// Builder Checker
class BuilderChecker<T> extends StatelessWidget {
  const BuilderChecker({
    Key? key,
    required this.snapshot,
    required this.builder,
    this.onNone,
    this.onWaiting,
    this.onError,
    this.indicator = true,
  }) : super(key: key);

  final AsyncSnapshot<T> snapshot;
  final WidgetBuilder builder;
  final Widget? onNone;
  final Widget? onWaiting;
  final Widget? onError;
  final bool indicator;

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        if (onNone != null) return onNone!;
        return const ExceptionIndicator('无数据');
      case ConnectionState.waiting:
        if (onWaiting != null) return onWaiting!;
        return Offstage(
          offstage: !indicator,
          child: defaultIndicator,
        );
      default:
        if (snapshot.hasError) {
          if (onError != null) return onError!;

          if (snapshot.error is HttpException) {
            return ExceptionIndicator((snapshot.error as HttpException).message);
          }

          return const ExceptionIndicator('网络错误');
        }
        return builder(context);
    }
  }
}
