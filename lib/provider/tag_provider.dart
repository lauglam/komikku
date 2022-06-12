import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:komikku/database/hive.dart';
import 'package:komikku/dex/apis/manga_api.dart';
import 'package:komikku/dex/models/tag.dart';

class TagProvider extends ChangeNotifier {
  var tagsGrouped = <String, Map<String, String>>{};
  var selectedTags = <String, String>{};

  Future<void> get() async {
    final response = await MangaApi.getTagListAsync();
    tagsGrouped = groupBy<Tag, String>(response.data, (p0) => p0.attributes.group)
        .map((key, value) => MapEntry(key, _toMap(value)));
  }

  /// 清除所有已选的标签
  void clear() => selectedTags.clear();

  /// 添加标签
  void addAll(MapEntry<String, String> value) {
    selectedTags.addEntries([value]);
    notifyListeners();
  }

  /// 移除标签
  void removeValue(String value) {
    selectedTags.removeWhere((k, v) => v == value);
    notifyListeners();
  }

  Map<String, String> _toMap(List<Tag> tags) {
    var value = <String, String>{};
    for (var tag in tags) {
      final nameMap = tag.attributes.name.toJson();
      var name = nameMap.values.first;
      for (var entry in nameMap.entries) {
        if (!HiveDatabase.translatedLanguage.contains(entry.key)) continue;
        name = entry.value;
      }
      value.addAll({tag.id: name});
    }

    return value;
  }
}
