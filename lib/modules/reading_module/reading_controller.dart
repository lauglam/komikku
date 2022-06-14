import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/core/utils/extensions.dart';
import 'package:komikku/core/utils/timeago.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/modules/details_module/details_controller.dart';
import 'package:komikku/data/hive.dart';
import 'package:komikku/dex/apis/at_home_api.dart';
import 'package:komikku/dex/retrieving.dart';
import 'package:komikku/dto/chapter_dto.dart';
import 'package:komikku/global_widgets/widgets.dart';

class ReadingController extends GetxController {
  /// 滚动控制器
  final scrollController = ScrollController();

  /// 当前所在的章节的id
  final _currentChapterId = ''.obs;

  get currentChapterId => _currentChapterId.value;

  set currentChapterId(value) => _currentChapterId.value = value;

  /// 当前所在的数组中的位置
  final _currentIndex = 0.obs;

  get currentIndex => _currentIndex.value;

  set currentIndex(value) => _currentIndex.value = value;

  /// 章节图片地址列表
  final _pages = <String>[].obs;

  get pages => _pages;

  /// 是否在加载中
  final _loading = false.obs;

  get loading => _loading.value;

  set loading(value) => _loading.value = value;

  /// 二维数组
  /// 同一章节里的所有可选章节
  /// example:
  /// [第59章, [扫描组1的上传], [扫描组3的上传], [扫描组3的上传]]
  /// [第58章, [扫描组1的上传], [扫描组3的上传], [扫描组3的上传]]
  /// [第57章, [扫描组1的上传], [扫描组3的上传], [扫描组3的上传]]
  final _chapters = <Iterable<ChapterDto>>[].obs;

  get chapters => _chapters;

  set chapters(value) => _chapters.value = value;

  /// 阅读进度
  final _readingProgress = 0.obs;

  get readingProgress => _readingProgress.value;

  /// [ReadingController]的单例
  static ReadingController get to => Get.find();

  @override
  void onInit() async {
    scrollController.addListener(_listener);
    super.onInit();
  }

  /// 获取章节图片
  Future<void> getChapterPages() async {
    try {
      _loading.value = true;
      final atHome = await AtHomeApi.getHomeServerUrlAsync(_currentChapterId.value);

      // 压缩质量的图片
      if (HiveDatabase.dataSaver) {
        _pages.value = Retrieving.getChapterPagesOnSaver(
          atHome.baseUrl,
          atHome.chapter.hash,
          atHome.chapter.dataSaver,
        );
      } else {
        _pages.value = Retrieving.getChapterPages(
          atHome.baseUrl,
          atHome.chapter.hash,
          atHome.chapter.data,
        );
      }
    } finally {
      _loading.value = false;
    }
  }

  /// 滚动监听
  Future<void> _listener() async {
    if (scrollController.onBottom) {
      if (_currentIndex.value == _chapters.length - 1) {
        showText(text: '您已经读到最新一章');
        return;
      }
      await _pageTurn(true);
    }

    if (scrollController.onTop) {
      if (_currentIndex.value == 0) {
        showText(text: '往后看吧，前面没有了');
        return;
      }
      await _pageTurn(false);
    }

    // 阅读进度
    if (scrollController.positions.isNotEmpty) {
      final current = scrollController.position.pixels;
      final max = scrollController.position.maxScrollExtent;
      _readingProgress.value = (current / max * 100).round();
    }
  }

  /// 翻页
  Future<void> _pageTurn(bool next) async {
    // 是否是下一章
    next ? _currentIndex.value++ : _currentIndex.value--;
    final values = _chapters.elementAt(_currentIndex.value).toList();

    // 只有一条内容时，不弹窗显示，而是自己显示上一章/下一章
    if (values.length == 1) {
      _currentChapterId.value = values[0].id;

      // 延迟200毫秒
      await Future.delayed(const Duration(milliseconds: 200), () => _readingProgress.value = 0);

      // 设为已读
      DetailsController.to.markMangaRead(values[0].id);

      // 更新
      getChapterPages();
      return;
    }

    await showBottomModal(
      title: '第 ${values[0].chapter ?? _currentIndex} 章',
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: values.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: BottomModalItem(
              title: '${values[index].title ?? index}',
              subtitle1: timeAgo(values[index].readableAt),
              subtitle2: values[index].scanlationGroup ?? '',
              subtitle3: values[index].uploader ?? '',
              subtitle4: '共 ${values[index].pages} 页',
              onTap: () async {
                // 点击事件时，再次将页数更改（相当于更改了2次，但后续在关闭时会恢复一次）
                next ? _currentIndex.value++ : _currentIndex.value--;
                Navigator.pop(context);
                _currentChapterId.value = values[index].id;

                // 延迟200毫秒
                await Future.delayed(
                    const Duration(milliseconds: 200), () => _readingProgress.value = 0);

                // 设为已读
                DetailsController.to.markMangaRead(values[index].id);

                // 更新
                getChapterPages();
              },
            ),
          );
        },
      ),
      // 关闭时恢复一次（此时如果没有onTap操作，则状态未变）
    ).then((value) => next ? _currentIndex.value-- : _currentIndex.value++);
  }
}
