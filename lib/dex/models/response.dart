import 'package:json_annotation/json_annotation.dart';
import 'package:komikku/dex/models/enum/result.dart';

import 'enum/response_type.dart';

/// 页响应
abstract class PageResponse<T> extends OkResponse<List<T>> {
  final int limit;
  final int offset;
  final int total;

  PageResponse({
    required super.response,
    required super.data,
    required this.limit,
    required this.offset,
    required this.total,
  });
}

/// 成功响应
class OkResponse<T> {
  final ResponseType response;
  final T data;

  OkResponse({
    required this.response,
    required this.data,
  });
}

/// 响应
class Response {
  final Result result;

  Response({
    required this.result,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        result: $enumDecode(resultEnumMap, json['result']),
      );

  Map<String, dynamic> toJson() => {
        'result': resultEnumMap[result],
      };
}
