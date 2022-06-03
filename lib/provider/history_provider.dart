import 'package:flutter/cupertino.dart';
import 'package:komikku/database/db_helper.dart';
import 'package:komikku/entities/history.dart';
import 'package:uuid/uuid.dart';

class HistoryProvider extends ChangeNotifier {
  /// 历史表
  var histories = <History>[];

  /// 选择所有
  Future<void> selectAll() async {
    final dataList = await DBHelper.selectAll(DBHelper.histories);

    histories = dataList
        .map((item) => History(
              id: item['id'],
              mangaId: item['manga_id'],
              chapterId: item['chapter_id'],
              updatedAt: DateTime.parse(item['updated_at']),
              createdAt: DateTime.parse(item['created_at']),
            ))
        .toList();

    notifyListeners();
  }

  /// 插入
  Future<void> insert({required String mangaId, required String chapterId}) async {
    var dateNow = DateTime.now();

    final history = History(
      id: const Uuid().v1(),
      mangaId: mangaId,
      chapterId: chapterId,
      updatedAt: dateNow,
      createdAt: dateNow,
    );

    histories.add(history);

    await DBHelper.insert(DBHelper.histories, {
      'id': history.id,
      'manga_id': history.mangaId,
      'chapter_id': history.chapterId,
      'updated_at': history.updatedAt.toIso8601String(),
      'created_at': history.createdAt.toIso8601String(),
    });

    notifyListeners();
  }

  /// 更新
  Future<void> update({
    required String id,
    required String chapterId,
  }) async {
    await DBHelper.update(
      DBHelper.histories,
      {'chapter_id': chapterId},
      id,
    );

    notifyListeners();
  }
}
