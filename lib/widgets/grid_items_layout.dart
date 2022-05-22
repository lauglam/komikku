import 'package:flutter/material.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// 子项布局
class GridItemsLayout extends StatelessWidget {
  final MangaDto dto;
  final TitleStyle titleStyle;

  const GridItemsLayout({
    Key? key,
    required this.dto,
    required this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: CachedNetworkImage(
        imageUrl: dto.imageUrl,
        fit: BoxFit.cover,
        // placeholder: (context, url) => Image.asset('assets/images/image-default.png'),
        errorWidget: (context, url, error) =>
            Image.asset('assets/images/image-failed.png'),
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: Transform.scale(
            scale: 0.7,
            child: CircularProgressIndicator(
              value: progress.progress,
            ),
          ),
        ),
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
              title: _TitleText(text: dto.title),
              subtitle: _TitleText(text: dto.subtitle),
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
              title: _TitleText(text: dto.title),
              subtitle: _TitleText(text: dto.subtitle),
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
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 12,
      ),
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
