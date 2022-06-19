class Retrieving {
  static const _retrievingCoverArtUrl = 'https://uploads.mangadex.org/covers';

  /// Get original quality cover art.
  static String getCoverArtOnOriginal(String mangaId, String filename) {
    return '$_retrievingCoverArtUrl/$mangaId/$filename';
  }

  /// Get 512px quality cover art.
  static String getCoverArtOn512(String mangaId, String filename) {
    return '$_retrievingCoverArtUrl/$mangaId/$filename.512.jpg';
  }

  /// Get 256px quality cover art.
  static String getCoverArtOn256(String mangaId, String filename) {
    return '$_retrievingCoverArtUrl/$mangaId/$filename.256.jpg';
  }

  /// Get chapter pages image url.
  static List<String> getChapterPages(
      String baseUrl, String hash, List<String> filenames) {
    return filenames
        .map((filename) => '$baseUrl/data/$hash/$filename')
        .toList();
  }

  /// Get chapter pages image url (data saver).
  static List<String> getChapterPagesOnSaver(
      String baseUrl, String hash, List<String> filenames) {
    return filenames
        .map((filename) => '$baseUrl/data-saver/$hash/$filename')
        .toList();
  }
}
