import 'package:hive_flutter/hive_flutter.dart';

class HiveService with HiveServiceMixin {}

mixin HiveServiceMixin {
  /// The name for hive database.
  static const _masterBox = 'master';

  get masterBox => _masterBox;

  /// Get the [value] of [key] from hive database.
  dynamic get(dynamic key) {
    final box = Hive.box(_masterBox);

    return box.get(key);
  }

  /// Put the [key] and [value] to hive database.
  /// If the [key] already exists, the [value] will be overwritten.
  Future<void> put(dynamic key, dynamic value) async {
    final box = Hive.box(_masterBox);

    return box.put(key, value);
  }

  /// Delete the [value] of [key] from hive database.
  Future<void> delete(dynamic key) async {
    final box = Hive.box(_masterBox);

    return box.delete(key);
  }
}
