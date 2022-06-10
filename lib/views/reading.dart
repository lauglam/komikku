import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komikku/dex/apis/at_home_api.dart';
import 'package:komikku/dex/retrieving.dart';
import 'package:komikku/dto/chapter_dto.dart';
import 'package:komikku/provider/chapter_read_marker_provider.dart';
import 'package:komikku/provider/data_saver_provider.dart';
import 'package:komikku/utils/extensions.dart';
import 'package:komikku/utils/timeago.dart';
import 'package:komikku/utils/toast.dart';
import 'package:komikku/widgets/bottom_modal_item.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:provider/provider.dart';

/// 阅读页
class Reading extends StatefulWidget {
  const Reading({
    Key? key,
    required this.id,
    required this.index,
    required this.arrays,
  }) : super(key: key);

  /// 当前的章节id
  /// 因为每个章节可能存在多个扫描组的内容，所以必须明确章节id
  final String id;

  /// 当前所处在[arrays]中的位置
  final int index;

  /// 二维数组
  /// 章节与章节内多个扫描组的内容
  /// 当章节内只有一个扫描组内容时，List.length = 1
  final Iterable<Iterable<ChapterDto>> arrays;

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  final _scrollController = ScrollController();
  final _progressNotifier = ValueNotifier(0);
  late String _currentId = widget.id;
  late int _currentIndex = widget.index;

  late final _provider1 = Provider.of<DataSaverProvider>(context, listen: false);
  late final _provider2 = Provider.of<ChapterReadMarkerProvider>(context, listen: false);

  @override
  void initState() {
    _scrollController.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: FutureBuilder<List<String>>(
        future: _getChapterPages(),
        builder: (context, snapshot) {
          return BuilderChecker(
            snapshot: snapshot,
            builder: (context) => Stack(
              fit: StackFit.expand,
              children: [
                // 主内容
                ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: snapshot.data![index],
                      fit: BoxFit.fitWidth,
                      fadeOutDuration: const Duration(milliseconds: 1),
                      progressIndicatorBuilder: (context, url, progress) {
                        return _ProgressIndicator(
                          index: '${index + 1}',
                          progress: progress.progress,
                        );
                      },
                      errorWidget: (context, url, progress) =>
                          Image.asset('assets/images/image-failed.png'),
                    );
                  },
                ),

                // 右下角显示（阅读进度、章节）
                Align(
                  alignment: Alignment.bottomRight,
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(2),
                      topRight: Radius.circular(2),
                    ),
                    textStyle: const TextStyle(color: Colors.white),
                    color: Colors.black54,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: ValueListenableBuilder<int>(
                        valueListenable: _progressNotifier,
                        builder: (context, value, child) => Text(
                          '$value %    第 ${widget.arrays.elementAt(_currentIndex).first.chapter ?? _currentIndex} 章',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// 获取章节图片
  Future<List<String>> _getChapterPages() async {
    _provider1.get();
    final atHome = await AtHomeApi.getHomeServerUrlAsync(_currentId);

    // 压缩质量的图片
    if (_provider1.dataSaver) {
      return Retrieving.getChapterPagesOnSaver(
        atHome.baseUrl,
        atHome.chapter.hash,
        atHome.chapter.dataSaver,
      );
    }
    return Retrieving.getChapterPages(atHome.baseUrl, atHome.chapter.hash, atHome.chapter.data);
  }

  /// 滚动监听
  Future<void> listener() async {
    if (_scrollController.onBottom) {
      if (_currentIndex == widget.arrays.length - 1) {
        showText(text: '您已经读到最新一章');
        return;
      }
      await _pageTurn(true);
    }

    if (_scrollController.onTop) {
      if (_currentIndex == 0) {
        showText(text: '往后看吧，前面没有了');
        return;
      }
      await _pageTurn(false);
    }

    // 阅读进度
    if (_scrollController.positions.isNotEmpty) {
      final current = _scrollController.position.pixels;
      final max = _scrollController.position.maxScrollExtent;
      _progressNotifier.value = (current / max * 100).round();
    }
  }

  /// 翻页
  Future<void> _pageTurn(bool next) async {
    // 是否是下一章
    next ? _currentIndex++ : _currentIndex--;
    final values = widget.arrays.elementAt(_currentIndex).toList();

    // 只有一条内容时，不弹窗显示，而是自己显示上一章/下一章
    if (values.length == 1) {
      setState(() => _currentId = values[0].id);

      // 延迟200毫秒
      Future.delayed(const Duration(milliseconds: 200), () => _progressNotifier.value = 0);

      // 设为已读
      await _provider2.mark(values[0].id);
      return;
    }

    await showBottomModal(
      context: context,
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
                next ? _currentIndex++ : _currentIndex--;
                Navigator.pop(context);
                setState(() => _currentId = values[index].id);

                // 延迟200毫秒
                Future.delayed(
                    const Duration(milliseconds: 200), () => _progressNotifier.value = 0);

                // 设为已读
                await _provider2.mark(values[index].id);
              },
            ),
          );
        },
      ),
      // 关闭时恢复一次（此时如果没有onTap操作，则状态未变）
    ).then((value) => next ? _currentIndex-- : _currentIndex++);
  }
}

/// 图片加载进度
class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator({required this.index, required this.progress});

  final String index;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(index, style: const TextStyle(fontSize: 50, color: Colors.black54)),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            CircularProgressIndicator(value: progress),
          ],
        ),
      ),
    );
  }
}
