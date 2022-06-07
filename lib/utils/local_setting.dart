import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

/// 本地设置
class LocalSetting {
  /// 查询 .setting 文件
  static Future<Map<String, dynamic>> all() async {
    var file = await _file;
    return json.decode(await file.readAsString());
  }

  /// 往 .setting 文件中插入数据
  static Future<void> insert(Map<String, dynamic> map) async {
    var file = await _file;
    var oldMap = await json.decode(await file.readAsString()) as Map<String, dynamic>;

    for (var key in map.keys) {
      if (oldMap.containsKey(key)) {
        oldMap[key] = map[key];
      } else {
        oldMap.addAll({key: map[key]});
      }
    }

    file.writeAsString(json.encode(oldMap));
  }

  /// 从 .setting 文件中删除数据
  static Future<void> delete(key) async {
    var file = await _file;
    var oldMap = await json.decode(await file.readAsString()) as Map<String, dynamic>;

    if (oldMap.containsKey(key)) {
      oldMap.remove(key);
    }

    file.writeAsString(json.encode(oldMap));
  }

  /// 获取 .setting 文件
  static Future<File> get _file async {
    final directory = await getApplicationDocumentsDirectory();
    var file = File('${directory.path}/.setting');
    // 不存在则使用默认项新建
    if (!await file.exists()) file.writeAsString(json.encode(_default));

    return file;
  }

  /// 默认 .user 文件
  static const _default = {
    // 内容分级
    'content_rating': ['safe', 'suggestive', 'erotica', 'pornographic'],
    // 章节可用翻译语言
    'translated_language': ['zh', 'zh-hk'],
    // 阅读图片是否压缩
    'data_saver': false,
  };
}

/// 获取内容分级
Future<List<String>> getContentRating() async {
  var all = await LocalSetting.all();
  return all['content_rating'];
}

/// 设置内容分级
Future<void> setContentRating(List<String> contentRating) async =>
    await LocalSetting.insert({'content_rating': contentRating});
