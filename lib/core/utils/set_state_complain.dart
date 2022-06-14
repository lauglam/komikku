import 'package:flutter/scheduler.dart';

/// 在[setState()]抱怨之后执行[fn]
/// 解决异常：setState() or markNeedsBuild() called during build.
Future<void> noComplain(VoidCallback fn) async {
  // If there's a current frame.
  if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
    // Wait for the end of that frame.
    await SchedulerBinding.instance.endOfFrame;
  }
  fn();
}

/// 等待[setState()]抱怨
/// 解决异常：setState() or markNeedsBuild() called during build.
Future<void> get complain async {
  // If there's a current frame.
  if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
    // Wait for the end of that frame.
    await SchedulerBinding.instance.endOfFrame;
  }
}
