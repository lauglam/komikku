import 'package:flutter/foundation.dart';
import 'package:komikku/dex/apis/chapter_read_marker_api.dart';

class ChapterReadMarkerProvider extends ChangeNotifier {
  var chapterReadMarkers = <String>[];

  Future<void> get(String id) async {
    final response = await ChapterReadMarkerApi.getMangaReadMarkersAsync(id);
    chapterReadMarkers = response.data;
  }

  Future<void> mark(String id) async {
    await ChapterReadMarkerApi.markChapterRead(id);
    chapterReadMarkers.add(id);

    notifyListeners();
  }
}
