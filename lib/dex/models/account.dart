import 'package:json_annotation/json_annotation.dart';
import 'response.dart';

part 'account.g.dart';

/// 创建账号
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AccountCreate {
  /// 用户名
  final String username;

  /// 密码
  final String password;

  /// 邮箱
  final String email;

  AccountCreate({
    required this.username,
    required this.password,
    required this.email,
  });

  factory AccountCreate.fromJson(Map<String, dynamic> json) =>
      _$AccountCreateFromJson(json);

  Map<String, dynamic> toJson() => _$AccountCreateToJson(this);
}

/// 激活账号
typedef AccountActivateResponse = Response;

/// 重新激活
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class SendAccountActivationCode {
  /// 邮箱
  String email;

  SendAccountActivationCode({required this.email});

  factory SendAccountActivationCode.fromJson(Map<String, dynamic> json) =>
      _$SendAccountActivationCodeFromJson(json);

  Map<String, dynamic> toJson() => _$SendAccountActivationCodeToJson(this);
}

/// 完成恢复(修改密码)
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class RecoverComplete {
  /// 新密码
  final String newPassword;

  RecoverComplete({required this.newPassword});

  factory RecoverComplete.fromJson(Map<String, dynamic> json) =>
      _$RecoverCompleteFromJson(json);

  Map<String, dynamic> toJson() => _$RecoverCompleteToJson(this);
}
