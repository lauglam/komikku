import 'package:json_annotation/json_annotation.dart';

/// 标签模式
enum LogicMode {
  /// 或
  @JsonValue('OR')
  or,

  /// 且
  @JsonValue('AND')
  and,
}
