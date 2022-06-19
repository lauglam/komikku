import 'package:json_annotation/json_annotation.dart';
import 'login.dart';

part 'refresh_token.g.dart';

/// Refresh token response.
typedef RefreshResponse = LoginResponse;

/// Get session token request.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RefreshToken {
  /// The refresh token.
  final String token;

  RefreshToken({required this.token});

  factory RefreshToken.fromJson(Map<String, dynamic> json) => _$RefreshTokenFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenToJson(this);
}
