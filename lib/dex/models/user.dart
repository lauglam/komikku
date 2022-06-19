import 'package:json_annotation/json_annotation.dart';
import 'attributes/user_attributes.dart';
import 'enum/response_type.dart';
import 'relationship.dart';
import 'response.dart';

part 'user.g.dart';

/// 用户令牌
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserResponse extends OkResponse<User> {
  UserResponse({required super.response, required super.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

/// 用户
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class User {
  /// 用户id
  final String id;

  /// 用户属性
  final UserAttributes attributes;

  /// 关系
  final List<Relationship> relationships;

  User({
    required this.id,
    required this.attributes,
    required this.relationships,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
