part of 'me.dart';

/// 设置面板
class _SettingPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<DataSaverProvider>(context, listen: false).get();
    Provider.of<ContentRatingProvider>(context, listen: false).get();
    Provider.of<TranslatedLanguageProvider>(context, listen: false).get();

    return Consumer3<DataSaverProvider, ContentRatingProvider, TranslatedLanguageProvider>(
      builder: (context, provider1, provider2, provider3, child) {
        var dataSaver = provider1.dataSaver;
        var contentRating = List<String>.from(provider2.contentRating);
        var translatedLanguage = List<String>.from(provider3.translatedLanguage);
        return Card(
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Wrap(
              spacing: 20,
              children: [
                // 内容分级
                IconTextButton(
                  text: '内容分级',
                  icon: TaoIcons.film,
                  onPressed: () => showAlertDialog(
                    title: '内容分级',
                    content: _ContentRating(
                      contentRating: contentRating,
                      onChanged: (value) => contentRating = value,
                    ),
                    onConfirm: () async {
                      if (contentRating.isNotEmpty) {
                        provider2.set(contentRating);
                      }
                    },
                  ),
                ),

                // 章节语言
                IconTextButton(
                  text: '章节语言',
                  icon: TaoIcons.comment,
                  onPressed: () {
                    // TODO: 章节语言
                    showText(text: '功能暂未上线，敬请期待');
                  },
                ),

                // 本地化
                IconTextButton(
                  text: '图片质量',
                  icon: TaoIcons.image,
                  onPressed: () => showAlertDialog(
                    title: '图片质量',
                    content: _DataSaver(
                      dataSaver: provider1.dataSaver,
                      onChanged: (value) => dataSaver = value,
                    ),
                    onConfirm: () {
                      // 提示信息
                      if (dataSaver) showText(text: '阅读漫画时更快加载，但图片质量有所下降');
                      provider1.set(dataSaver);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
