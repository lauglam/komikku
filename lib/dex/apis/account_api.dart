import 'package:komikku/dex/models/account.dart';
import 'package:komikku/dex/models/user.dart';
import 'package:komikku/utils/http.dart';

class AccountApi {
  /// 创建账号
  static Future<UserResponse> createAccountAsync(AccountCreate create) async {
    var response = await HttpUtil().post('/account/create', params: create.toJson());
    return UserResponse.fromJson(response);
  }

  /// 激活账号
  static Future<AccountActivateResponse> activateAccountAsync(String code) async {
    var response = await HttpUtil().post('/account/activate/$code');
    return AccountActivateResponse.fromJson(response);
  }

  /// 重新发送激活码
  static Future<AccountActivateResponse> resendActivationCodeAsync(
      SendAccountActivationCode resend) async {
    var response = await HttpUtil().post('/account/activate/resend', params: resend.toJson());
    return AccountActivateResponse.fromJson(response);
  }

  /// 恢复账号(修改密码)
  static Future<AccountActivateResponse> recoverAccountAsync(
      SendAccountActivationCode resend) async {
    var response = await HttpUtil().post('/account/recover');
    return AccountActivateResponse.fromJson(response);
  }

  /// 完成恢复账号(修改密码)
  static Future<AccountActivateResponse> completeAccountRecoverAsync(
      String code, RecoverComplete complete) async {
    var response = await HttpUtil().post('/account/recover/$code', params: complete.toJson());
    return AccountActivateResponse.fromJson(response);
  }
}
