import 'dart:async';

import 'package:flutter/material.dart';
import 'package:komikku/dex/apis.dart';
import 'package:komikku/dex/models.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/dto/tag_dto.dart';
import 'package:komikku/utils/extensions.dart';
import 'package:komikku/utils/icons.dart';
import 'package:komikku/utils/toast.dart';
import 'package:komikku/views/details.dart';
import 'package:komikku/widgets/advanced%20_search.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/chip.dart';
import 'package:komikku/widgets/manga_list_view_item.dart';
import 'package:komikku/widgets/search_bar.dart';

/// 搜索页面
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _streamController = StreamController<List<MangaDto>>();
  final _chipValueNotifier = ValueNotifier(false);
  final _scrollController = ScrollController();
  final _cacheMangaList = <MangaDto>[];
  final _includedTags = <String>[];
  Future<List<TagDto>>? _tagListFuture;

  String _queryTitle = '';

  final _limit = 10;
  int _offset = 0;

  Future<void> _addMangaListToSink({bool refresh = false}) async {
    if (refresh) {
      _cacheMangaList.clear();
      _offset = 0;
    }

    _cacheMangaList.addAll(await _searchManga());
    // 克隆一次，防止在clear()时影响_streamController
    var clone = _cacheMangaList.map((e) => MangaDto.fromJson(e.deepClone)).toList();
    _streamController.sink.add(clone);
    _offset += _limit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: SearchAppBar(
          hintText: '搜索',
          onSubmitted: (value) async {
            _queryTitle = value;
            await _addMangaListToSink(refresh: true);
          },
        ),
        actions: [
          TextButton(
            child: const Text('取消', style: TextStyle(fontSize: 15, color: Colors.black)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      // 底部高级搜索
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        clipBehavior: Clip.antiAlias,
        child: const Icon(TaoIcons.filter),
        onPressed: () async {
          // 键盘是否是弹起状态
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }

          showAlertDialog(
            title: '高级搜索',
            insetPadding: const EdgeInsets.all(0),
            content: FutureBuilder<List<TagDto>>(
              future: _tagListFuture,
              builder: (context, snapshot) {
                return BuilderChecker(
                  snapshot: snapshot,
                  // 在等待时撑满整个搜索屏幕
                  waiting: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  builder: (context) {
                    return SingleChildScrollView(
                      child: AdvancedSearch(
                        dtos: snapshot.data!,
                        selected: (value) => _includedTags.contains(value),
                        onChanged: (flag, value) {
                          flag ? _includedTags.add(value) : _includedTags.remove(value);
                          _chipValueNotifier.value = !_chipValueNotifier.value;
                        },
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 已选标签
            ValueListenableBuilder(
              valueListenable: _chipValueNotifier,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CanDeleteChipWarp(
                  values: _includedTags,
                  onDeleted: (value) {
                    if (_includedTags.contains(value)) {
                      _includedTags.remove(value);
                    }
                  },
                ),
              ),
            ),

            // 内容
            Expanded(
              child: StreamBuilder<List<MangaDto>>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  return BuilderChecker(
                    indicator: false,
                    snapshot: snapshot,
                    builder: (context) {
                      if (snapshot.data != null && snapshot.data!.isEmpty) {
                        return const Center(child: Text('没有找到漫画'));
                      }
                      return ListView.builder(
                        controller: _scrollController,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              /// 在刷新时点击可能会出现index > snapshot.data!.length的情况
                              if (index < snapshot.data!.length) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Details(dto: snapshot.data![index]),
                                  ),
                                );
                              }
                            },
                            child: MangaListViewItem(dto: snapshot.data![index]),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(listener);
    _tagListFuture = _getTagList();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    _scrollController.dispose();
  }

  Future<void> listener() async {
    if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
      await _addMangaListToSink();
    }
  }

  /// 搜索漫画
  Future<List<MangaDto>> _searchManga() async {
    var query = MangaListQuery(
      limit: _limit,
      offset: _offset,
      title: _queryTitle,
      includes: ['cover_art', 'author'],
      contentRating: [
        ContentRating.safe,
        ContentRating.suggestive,
        ContentRating.erotica,
        ContentRating.pornographic,
      ],
      availableTranslatedLanguage: ['zh', 'zh-hk'],
      includedTags: _includedTags.isEmpty ? null : _includedTags,
    );

    if (_includedTags.isNotEmpty) {
      var tagList = await _tagListFuture;
      var ids = tagList!.where((e) => _includedTags.contains(e.name)).map((e) => e.id);
      query.includedTags = ids.toList();
    }

    var response = await MangaApi.getMangaListAsync(
      query: query,
      order: MangaListOrder(relevance: OrderMode.desc),
    );

    return response.data.map((e) => MangaDto.fromSource(e)).toList();
  }

  /// 获取标签列表
  Future<List<TagDto>> _getTagList() async {
    var response = await MangaApi.getTagListAsync();
    return response.data.map((e) => TagDto.fromSource(e)).toList();
  }
}
