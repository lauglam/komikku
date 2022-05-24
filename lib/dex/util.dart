/// 建造请求Uri
String buildUri({
  required String path,
  Map<String, dynamic>? queryParameters,
  String? order,
}) {
  var uri = Uri(
    path: path,
    queryParameters: queryParameters,
  );

  path = uri.toString();
  return order == null
      ? path
      : queryParameters == null
          ? '$path?$order'
          : '$path&$order';
}
