// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAttributes _$UserAttributesFromJson(Map<String, dynamic> json) =>
    UserAttributes(
      username: json['username'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      version: json['version'] as int,
    );

Map<String, dynamic> _$UserAttributesToJson(UserAttributes instance) =>
    <String, dynamic>{
      'username': instance.username,
      'roles': instance.roles,
      'version': instance.version,
    };
