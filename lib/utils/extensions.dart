import 'dart:convert';

extension CollectionExtensions<T> on T {
  dynamic get deepClone => jsonDecode(jsonEncode(this));
}
