import 'package:json_annotation/json_annotation.dart';
import 'login.dart';

part 'refresh_token.g.dart';

/// 刷新响应
typedef RefreshResponse = LoginResponse;

/// 刷新请求
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RefreshToken {
  /// 刷新令牌
  final String token;

  RefreshToken({required this.token});

  factory RefreshToken.fromJson(Map<String, dynamic> json) => _$RefreshTokenFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenToJson(this);
}
