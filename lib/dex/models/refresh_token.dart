import 'package:komikku/dex/models/login.dart';

/// 刷新响应
typedef RefreshResponse = LoginResponse;

/// 刷新请求
class RefreshToken {
  String token;

  RefreshToken({required this.token});

  factory RefreshToken.fromJson(Map<String, dynamic> json) => RefreshToken(
        token: json['token'] as String,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}
