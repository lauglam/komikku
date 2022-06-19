import '../models/account.dart';
import '../models/user.dart';
import '../../core/utils/http.dart';

class AccountApi {
  /// Create account.
  @Deprecated('官方不允许App进行注册，注册需要移步官网')
  static Future<UserResponse> createAccountAsync(AccountCreate create) async {
    final response =
        await HttpUtil().post('/account/create', params: create.toJson());
    return UserResponse.fromJson(response);
  }

  /// Activate account.
  @Deprecated('官方不允许App进行注册，注册需要移步官网')
  static Future<AccountActivateResponse> activateAccountAsync(
      String code) async {
    final response = await HttpUtil().post('/account/activate/$code');
    return AccountActivateResponse.fromJson(response);
  }

  /// Resent the activate code.
  @Deprecated('官方不允许App进行注册，注册需要移步官网')
  static Future<AccountActivateResponse> resendActivationCodeAsync(
      SendAccountActivationCode resend) async {
    final response = await HttpUtil()
        .post('/account/activate/resend', params: resend.toJson());
    return AccountActivateResponse.fromJson(response);
  }

  /// Recover account (change password).
  @Deprecated('官方不允许App进行注册，注册需要移步官网')
  static Future<AccountActivateResponse> recoverAccountAsync(
      SendAccountActivationCode resend) async {
    final response = await HttpUtil().post('/account/recover');
    return AccountActivateResponse.fromJson(response);
  }

  /// Complete recover (change password).
  @Deprecated('官方不允许App进行注册，注册需要移步官网')
  static Future<AccountActivateResponse> completeAccountRecoverAsync(
      String code, RecoverComplete complete) async {
    final response = await HttpUtil()
        .post('/account/recover/$code', params: complete.toJson());
    return AccountActivateResponse.fromJson(response);
  }
}
