// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      result: $enumDecode(_$ResultEnumMap, json['result']),
    );

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'result': _$ResultEnumMap[instance.result],
    };

const _$ResultEnumMap = {
  Result.ok: 'ok',
  Result.error: 'error',
};
