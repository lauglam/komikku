import 'package:json_annotation/json_annotation.dart';

enum LogicMode {
  /// Or.
  @JsonValue('OR')
  or,

  /// And.
  @JsonValue('AND')
  and,
}
