import 'package:komikku/dex/models/response.dart';

/// 创建账号
class AccountCreate {
  final String username;
  final String password;
  final String email;

  AccountCreate({
    required this.username,
    required this.password,
    required this.email,
  });

  factory AccountCreate.fromJson(Map<String, dynamic> json) => AccountCreate(
        username: json['username'] as String,
        password: json['password'] as String,
        email: json['email'] as String,
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'email': email,
      };
}

/// 激活账号
typedef AccountActivateResponse = Response;

/// 重新激活
class SendAccountActivationCode {
  String email;

  SendAccountActivationCode({required this.email});

  factory SendAccountActivationCode.fromJson(Map<String, dynamic> json) =>
      SendAccountActivationCode(
        email: json['email'] as String,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}

/// 完成恢复(修改密码)
class RecoverComplete {
  final String newPassword;

  RecoverComplete({required this.newPassword});

  factory RecoverComplete.fromJson(Map<String, dynamic> json) => RecoverComplete(
        newPassword: json['newPassword'] as String,
      );

  Map<String, dynamic> toJson() => {
        'newPassword': newPassword,
      };
}
