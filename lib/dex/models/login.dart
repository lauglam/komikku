import 'package:json_annotation/json_annotation.dart';
import 'enum/result.dart';
import 'response.dart';
import 'token.dart';

part 'login.g.dart';

/// 登录响应
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LoginResponse extends Response {
  /// 令牌
  Token token;

  LoginResponse({required this.token, required super.result});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

/// 登录请求
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Login {
  /// 用户名
  /// [username] 和 [email] 必须设置一个或两个
  @JsonKey()
  final String? username;

  /// 密码
  final String password;

  /// 邮箱
  /// [username] 和 [email] 必须设置一个或两个
  final String? email;

  Login({
    this.username,
    this.email,
    required this.password,
  }) : assert(username != null || email != null, 'Email and password cannot both be null');

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
