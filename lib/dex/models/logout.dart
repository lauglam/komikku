import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/enum/result.dart';
import 'package:komikku/dex/models/response.dart';

class LogoutResponse extends Response {
  LogoutResponse({required super.result});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
        result: $enumDecode(resultEnumMap, json['result']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'result': resultEnumMap[result],
      };
}
