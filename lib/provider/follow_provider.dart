import 'package:flutter/material.dart';
import 'package:komikku/dex/apis/manga_api.dart';
import 'package:komikku/utils/auth.dart';

class FollowProvider extends ChangeNotifier {
  /// 订阅漫画
  Future<void> followManga(String id) async {
    // 未登录，直接返回
    if (!await Auth.userLoginState) return;
    await MangaApi.followMangaAsync(id);

    notifyListeners();
  }

  /// 退订漫画
  Future<void> unfollowManga(String id) async {
    // 未登录，直接返回
    if (!await Auth.userLoginState) return;
    await MangaApi.unfollowMangaAsync(id);

    notifyListeners();
  }
}
