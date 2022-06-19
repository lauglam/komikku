import 'package:json_annotation/json_annotation.dart';
import 'enum/result.dart';

import 'enum/response_type.dart';

part 'response.g.dart';

/// 页响应
abstract class PageResponse<T> extends OkResponse<List<T>> {
  /// 页限制
  final int limit;

  /// 偏移
  final int offset;

  /// 总共
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
  /// 响应类型
  final ResponseType response;

  /// 数据
  final T data;

  OkResponse({
    required this.response,
    required this.data,
  });
}

/// 响应
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Response {
  /// 结果
  final Result result;

  Response({
    required this.result,
  });

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}
