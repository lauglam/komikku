// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      response: $enumDecode(_$ResponseTypeEnumMap, json['response']),
      data: User.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'response': _$ResponseTypeEnumMap[instance.response],
      'data': instance.data.toJson(),
    };

const _$ResponseTypeEnumMap = {
  ResponseType.entity: 'entity',
  ResponseType.collection: 'collection',
};

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      attributes:
          UserAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
      relationships: (json['relationships'] as List<dynamic>)
          .map((e) => Relationship.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
      'relationships': instance.relationships.map((e) => e.toJson()).toList(),
    };
