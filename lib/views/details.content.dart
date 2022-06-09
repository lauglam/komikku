part of 'details.dart';

/// 漫画栅格
class _DetailsContent extends StatefulWidget {
  const _DetailsContent(this.id, {Key? key}) : super(key: key);

  /// 漫画id
  final String id;

  @override
  State<_DetailsContent> createState() => _DetailsContentState();
}

class _DetailsContentState extends State<_DetailsContent> {
  final _orderValueNotifier = ValueNotifier(OrderMode.desc);

  /// 因为需要排序，所以将响应内容缓存
  Future<ChapterListResponse>? _getMangaFeedFuture;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 排序
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Align(
            alignment: Alignment.centerRight,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: ValueListenableBuilder(
                valueListenable: _orderValueNotifier,
                builder: (context, value, child) => TextButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: MaterialStateProperty.all(Colors.black54),
                  ),
                  label: const Text('排序'),
                  icon: _orderValueNotifier.value == OrderMode.asc
                      ? const Icon(Icons.arrow_upward_rounded, size: 18)
                      : const Icon(Icons.arrow_downward_rounded, size: 18),
                  onPressed: () {
                    if (_orderValueNotifier.value == OrderMode.desc) {
                      _orderValueNotifier.value = OrderMode.asc;
                    } else {
                      _orderValueNotifier.value = OrderMode.desc;
                    }
                  },
                ),
              ),
            ),
          ),
        ),

        // 内容
        ValueListenableBuilder(
          valueListenable: _orderValueNotifier,
          builder: (context, value, child) => FutureBuilder<dynamic>(
            // 1: List<Chapter>   2: void
            future: Future.wait([
              _getMangaFeed(),
              Provider.of<ChapterReadMarkerProvider>(context, listen: false).get(widget.id)
            ]),
            builder: (context, snapshot) => BuilderChecker(
              snapshot: snapshot,
              onWaiting: child,
              builder: (context) => _DetailsGrid(chapters: snapshot.data![0]),
            ),
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 80),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        // 栅格
      ],
    );
  }

  /// 获取漫画章节
  Future<List<ChapterDto>> _getMangaFeed() async {
    final provider = Provider.of<LocalSettingProvider>(context, listen: false);
    await provider.get();

    final queryMap = {
      'limit': '96',
      'offset': '0',
      'contentRating[]': provider.contentRating,
      'translatedLanguage[]': provider.translatedLanguage,
      'includes[]': ["scanlation_group", "user"],

      // 切勿 readableAt: OrderMode.desc, 否则缺少章节
      'order[volume]': 'desc',
      'order[chapter]': 'desc',
    };

    final response = await (_getMangaFeedFuture ??= MangaApi.getMangaFeedAsync(
      widget.id,
      queryParameters: queryMap,
    ));

    final newItems = response.data.map((e) => ChapterDto.fromDex(e)).toList();

    if (!newItems
        .any((value) => value.chapter == null || double.tryParse(value.chapter!) == null)) {
      // 按章节排序
      if (_orderValueNotifier.value == OrderMode.desc) {
        newItems.sortByCompare(
          (value) => double.parse(value.chapter!),
          (double a, double b) => b.compareTo(a),
        );
      } else {
        newItems.sortByCompare(
          (value) => double.parse(value.chapter!),
          (double a, double b) => a.compareTo(b),
        );
      }
    } else {
      // 没有章节，按readableAt排序
      if (_orderValueNotifier.value == OrderMode.desc) {
        newItems.sortByCompare(
          (value) => value.readableAt,
          (DateTime a, DateTime b) => b.compareTo(a),
        );
      } else {
        newItems.sortByCompare(
          (value) => value.readableAt,
          (DateTime a, DateTime b) => a.compareTo(b),
        );
      }
    }

    return newItems;
  }
}

/// 漫画栅格
class _DetailsGrid extends StatelessWidget {
  const _DetailsGrid({Key? key, required this.chapters}) : super(key: key);

  final List<ChapterDto> chapters;

  // final List<String> chapterReadMarkers;

  @override
  Widget build(BuildContext context) {
    final itemsMap = chapters.groupListsBy((value) => value.chapter);

    return Consumer<ChapterReadMarkerProvider>(
      builder: (context, provider, child) {
        return GridView.builder(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 2,
          ),
          itemCount: itemsMap.length,
          // 必须设置shrinkWrap & physics
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, chapterIndex) {
            final values = itemsMap.values.elementAt(chapterIndex);

            // 因为排序的原因，所以要明确上一章到底位于数组的前一个还是后一个
            // 如果是倒序，则反转
            var ascIndex = chapterIndex;
            var ascArrays = itemsMap.values;
            if (chapters.length > 2 && chapters[0].readableAt.isAfter(chapters[1].readableAt)) {
              ascIndex = itemsMap.length - chapterIndex - 1;
              ascArrays = itemsMap.values.toList().reversed.toList();
            }

            // 按钮颜色
            Color buttonColor = Colors.orange;
            ButtonStyle? buttonStyle = ButtonStyle(
              side: MaterialStateProperty.all(const BorderSide(color: Colors.orangeAccent)),
            );

            if (values.any((e) => provider.chapterReadMarkers.contains(e.id))) {
              buttonColor = Colors.black38;
              buttonStyle = null;
            }

            // 单独按钮
            if (values.length < 2) {
              return OutlinedButton(
                style: buttonStyle,
                onPressed: () {
                  // 不等待
                  provider.mark(values[0].id);

                  // 跳转
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Reading(
                        id: values[0].id,
                        index: ascIndex,
                        arrays: ascArrays,
                      ),
                    ),
                  );
                },
                child: Text(
                  '${values[0].chapter ?? chapterIndex}',
                  style: TextStyle(color: buttonColor),
                ),
              );
            }

            // 弹出模态框按钮
            return OutlinedButton(
              style: buttonStyle,
              child: Text(
                '${values[0].chapter ?? chapterIndex}',
                style: TextStyle(color: buttonColor),
              ),
              onPressed: () async => await showBottomModal(
                context: context,
                title: '第 ${values[0].chapter ?? chapterIndex} 章',
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: values.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Material(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black12,
                        clipBehavior: Clip.antiAlias,
                        child: BottomModalItem(
                          title: '${values[index].title ?? index}',
                          subtitle1: timeAgo(values[index].readableAt),
                          subtitle2: values[index].scanlationGroup ?? '',
                          subtitle3: values[index].uploader ?? '',
                          subtitle4: '共 ${values[index].pages} 页',
                          onTap: () {
                            // 先关闭模态框
                            Navigator.pop(context);

                            // 不等待
                            provider.mark(values[index].id);

                            // 跳转到阅读页面
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Reading(
                                  id: values[index].id,
                                  index: ascIndex,
                                  arrays: ascArrays,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
