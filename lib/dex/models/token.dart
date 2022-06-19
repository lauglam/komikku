import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

/// User token.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Token {
  /// Session token.
  /// Expire time: 15min.
  final String session;

  /// Refresh token.
  /// Expire time: 30days.
  final String refresh;

  Token({
    required this.session,
    required this.refresh,
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
