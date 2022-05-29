import 'dart:async';

import 'package:flutter/material.dart';
import 'package:komikku/dex/apis.dart';
import 'package:komikku/dex/models.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/dto/tag_dto.dart';
import 'package:komikku/utils/icons.dart';
import 'package:komikku/utils/toast.dart';
import 'package:komikku/views/details.dart';
import 'package:komikku/widgets/advanced%20_search.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/manga_list_view_item.dart';
import 'package:komikku/widgets/search_bar.dart';

/// 搜索页面
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _scrollController = ScrollController();
  final _cacheMangaList = <MangaDto>[];
  final _includedTags = <String>[];
  Future<List<TagDto>>? _tagListFuture;
  Future<List<MangaDto>>? _submittedFuture;
  Widget? _alertWidget;

  String _queryTitle = '';

  int limit = 10;
  int offset = 0;

  Future<List<MangaDto>> _addMangaListToSink({bool refresh = false}) async {
    if (refresh) {
      _cacheMangaList.clear();
      offset = 0;
    }

    _cacheMangaList.addAll(await _searchManga());
    offset += limit;
    return _cacheMangaList;
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
          onSubmitted: (value) => setState(() {
            _queryTitle = value;
            _submittedFuture = _addMangaListToSink(refresh: true);
          }),
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
          var tagList = await _tagListFuture;
          showAlertDialog(
            title: '高级搜索',
            insetPadding: const EdgeInsets.all(0),
            content: _alertWidget ??= SingleChildScrollView(
              child: AdvancedSearch(
                dtos: tagList!,
                selected: (value) => _includedTags.contains(value),
                onChanged: (flag, value) =>
                    flag ? _includedTags.add(value) : _includedTags.remove(value),
              ),
            ),
          );
        },
      ),
      body: FutureBuilder<List<MangaDto>>(
        future: _submittedFuture,
        builder: (context, snapshot) {
          return BuilderChecker(
            snapshot: snapshot,
            none: const Center(child: Text('点击搜索框输入漫画名')),
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
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(listener);
    _tagListFuture = _getTagList();
  }

  void listener() {
    if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
      _addMangaListToSink();
    }
  }

  /// 搜索漫画
  Future<List<MangaDto>> _searchManga() async {
    var query = MangaListQuery(
      limit: limit,
      offset: offset,
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
