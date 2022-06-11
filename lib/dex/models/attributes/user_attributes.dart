import 'package:json_annotation/json_annotation.dart';

part 'user_attributes.g.dart';

/// 用户属性
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserAttributes {
  /// 用户名
  final String username;

  /// 角色
  final List<String> roles;

  /// 版本
  final int version;

  UserAttributes({
    required this.username,
    required this.roles,
    required this.version,
  });

  factory UserAttributes.fromJson(Map<String, dynamic> json) => _$UserAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$UserAttributesToJson(this);
}
