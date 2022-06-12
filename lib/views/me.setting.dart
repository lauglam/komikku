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
        var selectedDataSaver = false;
        var selectedContentRating = <String>[];
        var selectedTranslatedLanguage = <String>[];
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
                      selectedContentRating: provider2.contentRating,
                      onChanged: (value) => selectedContentRating = value,
                    ),
                    onConfirm: () async {
                      if (selectedContentRating.isNotEmpty) {
                        provider2.set(selectedContentRating);
                      }
                    },
                  ),
                ),

                // 章节语言
                IconTextButton(
                  text: '章节语言',
                  icon: TaoIcons.comment,
                  onPressed: () => showAlertDialog(
                    title: '章节语言',
                    content: _TranslatedLanguage(
                      selectedLanguage: provider3.translatedLanguage,
                      onChanged: (value) => selectedTranslatedLanguage = value,
                    ),
                    // translatedLanguage can be empty
                    onConfirm: () async => provider3.set(selectedTranslatedLanguage),
                  ),
                ),

                // 本地化
                IconTextButton(
                  text: '图片质量',
                  icon: TaoIcons.image,
                  onPressed: () => showAlertDialog(
                    title: '图片质量',
                    content: _DataSaver(
                      selectedDataSaver: provider1.dataSaver,
                      onChanged: (value) => selectedDataSaver = value,
                    ),
                    onConfirm: () {
                      // 提示信息
                      if (selectedDataSaver) showText(text: '阅读漫画时更快加载，但图片质量有所下降');
                      provider1.set(selectedDataSaver);
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
