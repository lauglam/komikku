import 'dart:io';

import 'package:flutter/material.dart';

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
        return const _CenterIconWeight('无数据');
      case ConnectionState.waiting:
        if (onWaiting != null) return onWaiting!;
        return Offstage(
          offstage: !indicator,
          child: const Center(child: CircularProgressIndicator()),
        );
      default:
        if (snapshot.hasError) {
          if (onError != null) return onError!;

          if (snapshot.error is HttpException) {
            return _CenterIconWeight((snapshot.error as HttpException).message);
          }

          return const _CenterIconWeight('未知错误');
        }
        return builder(context);
    }
  }
}

class _CenterIconWeight extends StatelessWidget {
  const _CenterIconWeight(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.android_outlined, size: 85, color: Colors.black12),
          Text(title, style: const TextStyle(fontSize: 18, color: Colors.black12)),
        ],
      ),
    );
  }
}
