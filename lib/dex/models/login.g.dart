// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: Token.fromJson(json['token'] as Map<String, dynamic>),
      result: $enumDecode(_$ResultEnumMap, json['result']),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'result': _$ResultEnumMap[instance.result],
      'token': instance.token.toJson(),
    };

const _$ResultEnumMap = {
  Result.ok: 'ok',
  Result.error: 'error',
};

Login _$LoginFromJson(Map<String, dynamic> json) => Login(
      username: json['username'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginToJson(Login instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('username', instance.username);
  val['password'] = instance.password;
  writeNotNull('email', instance.email);
  return val;
}
