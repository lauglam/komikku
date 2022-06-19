import 'package:json_annotation/json_annotation.dart';
import 'attributes/user_attributes.dart';
import 'enum/response_type.dart';
import 'relationship.dart';
import 'response.dart';

part 'user.g.dart';

/// User response.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserResponse extends OkResponse<User> {
  UserResponse({required super.response, required super.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

/// User.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class User {
  /// The id of user.
  final String id;

  /// The attributes of user.
  final UserAttributes attributes;

  /// The relationship of user.
  final List<Relationship> relationships;

  User({
    required this.id,
    required this.attributes,
    required this.relationships,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
