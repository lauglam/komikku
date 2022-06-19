import 'package:json_annotation/json_annotation.dart';

part 'user_attributes.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserAttributes {
  /// The name of this user.
  final String username;

  /// The role list of this user.
  final List<String> roles;

  /// The vision of this attributes.
  final int version;

  UserAttributes({
    required this.username,
    required this.roles,
    required this.version,
  });

  factory UserAttributes.fromJson(Map<String, dynamic> json) =>
      _$UserAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$UserAttributesToJson(this);
}
