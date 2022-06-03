class UserAttributes {
  final String username;
  final List<String> roles;
  final int version;

  UserAttributes({
    required this.username,
    required this.roles,
    required this.version,
  });

  factory UserAttributes.fromJson(Map<String, dynamic> json) => UserAttributes(
        username: json['username'] as String,
        roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
        version: json['version'] as int,
      );

  Map<String, dynamic> toJson() => {
        'username': username,
        'roles': roles,
        'version': version,
      };
}
