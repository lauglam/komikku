import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/enum/result.dart';
import 'package:komikku/dex/models/response.dart';
import 'package:komikku/dex/models/token.dart';

/// 登录响应
class LoginResponse extends Response {
  Token token;

  LoginResponse({required this.token, required super.result});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: Token.fromJson(json['token']),
        result: $enumDecode(resultEnumMap, json['result']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'token': token.toJson(),
        'result': resultEnumMap[result],
      };
}

/// 登录请求
class Login {
  final String? username;
  final String? email;
  final String password;

  Login({
    this.username,
    this.email,
    required this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        username: json['username'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String,
      );

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    val['password'] = password;
    writeNotNull('email', email);
    writeNotNull('username', username);
    return val;
  }
}
