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
  /// 倒序排序通知
  /// 默认为ture
  final _orderByDescValueNotifier = ValueNotifier(true);

  /// 倒序排序字典
  var _descChapters = <String, List<ChapterDto>>{};

  /// 正序排序字典
  var _ascChapters = <String, List<ChapterDto>>{};

  /// 因为已经将排序都装入了[_descChapters]和[_ascChapters]
  /// 所以将响应内容缓存，只执行一次
  Future<void>? _getMangaFeedFuture;

  /// 请求阅读记录的异步操作也只执行一次
  /// 如果在每次排序时都执行一次可能会导致网络请求过多
  Future<void>? _getMangaReadMarkersFuture;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 排序
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Align(
            alignment: Alignment.centerRight,
            child: ValueListenableBuilder(
              valueListenable: _orderByDescValueNotifier,
              builder: (context, value, child) => Directionality(
                textDirection: TextDirection.rtl,
                child: TextButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: MaterialStateProperty.all(Colors.black54),
                  ),
                  label: const Text('排序'),
                  icon: _orderByDescValueNotifier.value
                      ? const Icon(Icons.arrow_downward_rounded, size: 18)
                      : const Icon(Icons.arrow_upward_rounded, size: 18),
                  onPressed: () {
                    _orderByDescValueNotifier.value = !_orderByDescValueNotifier.value;
                  },
                ),
              ),
            ),
          ),
        ),

        // 内容
        ValueListenableBuilder(
          valueListenable: _orderByDescValueNotifier,
          builder: (context, value, child) => Futuristic<void>(
            futureBuilder: () => Future.wait([
              // 只执行一次请求
              _getMangaFeedFuture ??= _getMangaFeed(),
              _getMangaReadMarkersFuture ??=
                  Provider.of<ChapterReadMarkerProvider>(context, listen: false).get(widget.id)
            ]),
            initialBuilder: (context, execute) {
              execute();
              return const SizedBox.shrink();
            },
            errorBuilder: (context, error, execute) =>
                TryAgainExceptionIndicator(onTryAgain: execute),
            dataBuilder: (context, data) => _DetailsGrid(
              ascChapters: _ascChapters,
              descChapters: _descChapters,
              isDesc: _orderByDescValueNotifier.value,
            ),
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        // 栅格
      ],
    );
  }

  /// 获取漫画章节
  /// 此方法只执行一次
  Future<void> _getMangaFeed() async {
    final provider1 = Provider.of<ContentRatingProvider>(context, listen: false);
    final provider2 = Provider.of<TranslatedLanguageProvider>(context, listen: false);
    provider1.get();
    provider2.get();

    final queryMap = {
      'limit': '96',
      'offset': '0',
      'contentRating[]': provider1.contentRating,
      'translatedLanguage[]': provider2.translatedLanguage,
      'includes[]': ["scanlation_group", "user"],

      // 切勿 readableAt: OrderMode.desc, 否则缺少章节
      'order[volume]': 'desc',
      'order[chapter]': 'desc',
    };

    final response = await MangaApi.getMangaFeedAsync(
      widget.id,
      queryParameters: queryMap,
    );

    final newItems = response.data.map((e) => ChapterDto.fromDex(e)).toList();

    if (!newItems
        .any((value) => value.chapter == null || double.tryParse(value.chapter!) == null)) {
      // 按章节排序
      _descChapters = newItems
          .sortedByCompare(
            (value) => double.parse(value.chapter!),
            (double a, double b) => b.compareTo(a),
          )
          .groupListsBy(
            (e) => e.chapter!,
          );

      _ascChapters = newItems
          .sortedByCompare(
            (value) => double.parse(value.chapter!),
            (double a, double b) => a.compareTo(b),
          )
          .groupListsBy(
            (e) => e.chapter!,
          );
    } else {
      // 没有章节，按readableAt排序
      _descChapters = newItems
          .sortedByCompare(
            (value) => value.readableAt,
            (DateTime a, DateTime b) => b.compareTo(a),
          )
          .groupListsBy(
            (e) => '${e.readableAt}',
          );

      _ascChapters = newItems
          .sortedByCompare(
            (value) => value.readableAt,
            (DateTime a, DateTime b) => a.compareTo(b),
          )
          .groupListsBy(
            (e) => '${e.readableAt}',
          );
    }
  }
}
