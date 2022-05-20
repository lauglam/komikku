class HttpException implements Exception {
  int code;
  String message;

  HttpException({
    required this.code,
    required this.message,
  });

  @override
  String toString() => 'Exception: code $code, $message';
}
