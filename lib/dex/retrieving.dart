import 'package:komikku/dex/dex_settings.dart';

class Retrieving {
  /// 获取封面艺术原图
  static String getCoverArtOnOriginal(String mangaId, String filename) {
    return '$retrievingCoverArtUrl/$mangaId/$filename';
  }

  /// 获取封面艺术512px
  static String getCoverArtOn512(String mangaId, String filename) {
    return '$retrievingCoverArtUrl/$mangaId/$filename.512.jpg';
  }

  /// 获取封面艺术256px
  static String getCoverArtOn256(String mangaId, String filename) {
    return '$retrievingCoverArtUrl/$mangaId/$filename.256.jpg';
  }

  /// 获取章节图片
  static List<String> getChapterPages(
      String baseUrl, String hash, List<String> filenames) {
    return filenames
        .map((filename) => '$baseUrl/data/$hash/$filename')
        .toList();
  }

  /// 获取章节图片（压缩模式）
  static List<String> getChapterPagesOnSaver(
      String baseUrl, String hash, List<String> filenames) {
    return filenames
        .map((filename) => '$baseUrl/data-saver/$hash/$filename')
        .toList();
  }
}
