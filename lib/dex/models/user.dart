import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/attributes/user_attributes.dart';
import 'package:komikku/dex/models/enum/entity_type.dart';
import 'package:komikku/dex/models/enum/response_type.dart';
import 'package:komikku/dex/models/relationship.dart';
import 'package:komikku/dex/models/response.dart';

class UserResponse extends OkResponse<User> {
  UserResponse({required super.response, required super.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        response: $enumDecode(responseTypeEnumMap, json['response']),
        data: User.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'response': entityTypeEnumMap[response],
        'data': data.toJson(),
      };
}

class User {
  final String id;
  final UserAttributes attributes;
  final List<Relationship> relationships;

  User({
    required this.id,
    required this.attributes,
    required this.relationships,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        attributes: UserAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
        relationships: (json['relationships'] as List<dynamic>)
            .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': attributes.toJson(),
        'relationships': relationships.map((e) => e.toJson()).toList(),
      };
}
