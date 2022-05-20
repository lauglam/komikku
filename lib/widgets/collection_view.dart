import 'package:flutter/material.dart';
import 'package:komikku/dex/apis/chapter.dart';
import 'package:komikku/dex/models/chapter_list.dart';

/// GridView布局
class CollectionView extends StatefulWidget {
  const CollectionView({Key? key}) : super(key: key);

  @override
  State<CollectionView> createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {

  /// 获取漫画列表
  Future<List<_Manga>> _getMangaList() async {
    ChapterListResponse response = await ChapterApi.getChapterListAsync();
    return response.data
        .map((chapter) => _Manga(
            assetUrl: chapter.id, title: chapter.id, subtitle: chapter.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<_Manga>>(
      future: _getMangaList(),
      builder: (context, list) {
        switch (list.connectionState) {
          case ConnectionState.none:
            return const Text('数据为空');
          case ConnectionState.waiting:
            return const Text('数据加载中...');
          default:
            if (list.hasError) {
              return Text('出现错误: ${list.error}');
            } else {
              return GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                padding: const EdgeInsets.all(8),
                childAspectRatio: 1,
                children: list.data!
                    .map((manga) => _GridItemsLayout(
                        manga: manga, titleStyle: TitleStyle.footer))
                    .toList(),
              );
            }
        }
      },
    );
  }
}

/// 子项布局
class _GridItemsLayout extends StatelessWidget {
  final _Manga manga;
  final TitleStyle titleStyle;

  const _GridItemsLayout({
    Key? key,
    required this.manga,
    required this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        manga.assetUrl,
        fit: BoxFit.cover,
      ),
    );

    switch (titleStyle) {
      case TitleStyle.imageOnly:
        return image;
      case TitleStyle.header:
        return GridTile(
          header: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              title: _TitleText(text: manga.title),
              backgroundColor: Colors.black45,
            ),
          ),
          child: image,
        );
      case TitleStyle.footer:
        return GridTile(
          footer: Material(
            color: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridTileBar(
              title: _TitleText(text: manga.title),
              backgroundColor: Colors.black45,
            ),
          ),
          child: image,
        );
    }
  }
}

/// 标题
class _TitleText extends StatelessWidget {
  final String text;

  const _TitleText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text),
    );
  }
}

/// 标题样式
enum TitleStyle {
  /// 只有图片
  imageOnly,

  /// 在头部
  header,

  /// 在底部
  footer,
}

/// 漫画
class _Manga {
  final String assetUrl;
  final String title;
  final String subtitle;

  _Manga({
    required this.assetUrl,
    required this.title,
    required this.subtitle,
  });
}
