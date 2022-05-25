import 'package:flutter/material.dart';

class DelayPop extends StatelessWidget {
  const DelayPop({
    Key? key,
    required this.flag,
    required this.duration,
    required this.child,
  }) : super(key: key);

  final bool flag;
  final Duration duration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () async {
        // 如果正在执行关键任务，则等待再返回
        if (flag) await Future.delayed(duration);
        return true;
      },
    );
  }
}
