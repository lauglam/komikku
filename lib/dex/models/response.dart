import 'package:json_annotation/json_annotation.dart';
import 'enum/result.dart';

import 'enum/response_type.dart';

part 'response.g.dart';

/// Page response.
abstract class PageResponse<T> extends OkResponse<List<T>> {
  /// The page size of page.
  final int limit;

  /// The offset of page.
  final int offset;

  /// The total count of page.
  final int total;

  PageResponse({
    required super.response,
    required super.data,
    required this.limit,
    required this.offset,
    required this.total,
  });
}

/// Success response.
class OkResponse<T> {
  /// The type of response.
  final ResponseType response;

  /// The data of response.
  final T data;

  OkResponse({
    required this.response,
    required this.data,
  });
}

/// Response.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Response {
  /// The result of response.
  final Result result;

  Response({
    required this.result,
  });

  factory Response.fromJson(Map<String, dynamic> json) => _$ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}
