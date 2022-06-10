import 'package:flutter/foundation.dart';
import 'package:komikku/dex/apis/chapter_read_marker_api.dart';
import 'package:komikku/database/hive.dart';

class ChapterReadMarkerProvider extends ChangeNotifier {
  var chapterReadMarkers = <String>[];

  Future<void> get(String id) async {
    if (!userLoginState) return;
    final response = await ChapterReadMarkerApi.getMangaReadMarkersAsync(id);
    chapterReadMarkers = response.data;
  }

  Future<void> mark(String id) async {
    if (!userLoginState) return;
    await ChapterReadMarkerApi.markChapterRead(id);
    chapterReadMarkers.add(id);

    notifyListeners();
  }
}
