import 'package:flutter/scheduler.dart';

/// Execute [fn] after [setState()] complains
/// Solve exception: setState() or markNeedsBuild() called during build.
Future<void> noComplain(VoidCallback fn) async {
  // If there's a current frame.
  if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
    // Wait for the end of that frame.
    await SchedulerBinding.instance.endOfFrame;
  }
  fn();
}

/// Await [setState()] complains
/// Solve exception: setState() or markNeedsBuild() called during build.
Future<void> get complain async {
  // If there's a current frame.
  if (SchedulerBinding.instance.schedulerPhase != SchedulerPhase.idle) {
    // Wait for the end of that frame.
    await SchedulerBinding.instance.endOfFrame;
  }
}
