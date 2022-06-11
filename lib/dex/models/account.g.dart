// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountCreate _$AccountCreateFromJson(Map<String, dynamic> json) =>
    AccountCreate(
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$AccountCreateToJson(AccountCreate instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
    };

SendAccountActivationCode _$SendAccountActivationCodeFromJson(
        Map<String, dynamic> json) =>
    SendAccountActivationCode(
      email: json['email'] as String,
    );

Map<String, dynamic> _$SendAccountActivationCodeToJson(
        SendAccountActivationCode instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

RecoverComplete _$RecoverCompleteFromJson(Map<String, dynamic> json) =>
    RecoverComplete(
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$RecoverCompleteToJson(RecoverComplete instance) =>
    <String, dynamic>{
      'newPassword': instance.newPassword,
    };
