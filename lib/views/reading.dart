import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komikku/dex/apis/at_home_api.dart';
import 'package:komikku/dex/retrieving.dart';
import 'package:komikku/widgets/builder_checker.dart';

class Reading extends StatefulWidget {
  const Reading({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<Reading> createState() => _ReadingState();
}

class _ReadingState extends State<Reading> {
  bool successLoad = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: FutureBuilder<List<String>>(
        future: _getChapterPages(),
        builder: (context, snapshot) {
          return BuilderChecker(
            snapshot: snapshot,
            widget: () => ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  fadeOutDuration: const Duration(milliseconds: 0),
                  imageUrl: snapshot.data![index],
                  fit: BoxFit.fitWidth,
                  progressIndicatorBuilder: (context, url, progress) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, url, progress) =>
                      Image.asset('assets/images/image-failed.png'),
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// 获取章节图片
  Future<List<String>> _getChapterPages() async {
    var atHome = await AtHomeApi.getHomeServerUrlAsync(widget.id);
    return Retrieving.getChapterPages(atHome.baseUrl, atHome.chapter.hash, atHome.chapter.data);
  }
}
