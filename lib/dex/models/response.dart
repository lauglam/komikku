import 'package:komikku/dex/models/enum/result.dart';

import 'enum/response_type.dart';

/// 页响应
class PageResponse<T> extends SuccessResponse<T> {
  int limit;
  int offset;
  int total;

  PageResponse({
    required super.response,
    required super.data,
    required this.limit,
    required this.offset,
    required this.total,
  });
}

/// 成功响应
class SuccessResponse<T> {
  ResponseType response;
  T data;

  SuccessResponse({
    required this.response,
    required this.data,
  });
}

/// 响应
class Response {
  Result result;

  Response({
    required this.result,
  });
}
