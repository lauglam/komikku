/// 建造请求Uri
String buildUri({required String path, Map<String, dynamic>? queryParameters}) {
  var uri = Uri(
    path: path,
    queryParameters: queryParameters,
  );

  return Uri.decodeFull(uri.toString());
}
