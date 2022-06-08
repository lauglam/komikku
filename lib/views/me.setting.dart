part of 'me.dart';

/// 设置面板
class _SettingPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Provider.of<LocalSettingProvider>(context, listen: false).get(),
      builder: (context, snapshot) => BuilderChecker(
        snapshot: snapshot,
        builder: (context) => Consumer<LocalSettingProvider>(
          builder: (context, provider, child) {
            var contentRating = List<String>.from(provider.contentRating);
            var translatedLanguage = List<String>.from(provider.translatedLanguage);
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
                      onPressed: () {
                        showAlertDialog(
                          title: '内容分级',
                          content: _ContentRating(
                            contentRating: contentRating,
                            onChanged: (value) => contentRating = value,
                          ),
                          onConfirm: () async {
                            if (contentRating.isNotEmpty) {
                              await provider.set(contentRating: contentRating);
                            }
                          },
                        );
                      },
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
                      text: '本地化',
                      icon: TaoIcons.cycle,
                      onPressed: () {
                        // TODO: 本地化
                        showText(text: '功能暂未上线，敬请期待');
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// 内容分级
class _ContentRating extends StatefulWidget {
  const _ContentRating({required this.contentRating, required this.onChanged});

  final List<String> contentRating;
  final void Function(List<String> value) onChanged;

  @override
  State<_ContentRating> createState() => _ContentRatingState();
}

class _ContentRatingState extends State<_ContentRating> {
  late final contentRating = widget.contentRating;
  late final onChanged = widget.onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: const Text('安全'),
          value: contentRating.contains('safe'),
          onChanged: (value) {
            if (value == null) return;

            if (!value && contentRating.length == 1) {
              showText(text: '至少选择一项');
              return;
            }

            setState(() => value ? contentRating.add('safe') : contentRating.remove('safe'));
            onChanged(contentRating);
          },
        ),
        CheckboxListTile(
          title: const Text('性暗示'),
          value: contentRating.contains('suggestive'),
          onChanged: (value) {
            if (value == null) return;

            if (!value && contentRating.length == 1) {
              showText(text: '至少选择一项');
              return;
            }

            setState(
                () => value ? contentRating.add('suggestive') : contentRating.remove('suggestive'));
            onChanged(contentRating);
          },
        ),
        CheckboxListTile(
          title: const Text('涉黄'),
          value: contentRating.contains('erotica'),
          onChanged: (value) {
            if (value == null) return;

            if (!value && contentRating.length == 1) {
              showText(text: '至少选择一项');
              return;
            }

            setState(() => value ? contentRating.add('erotica') : contentRating.remove('erotica'));
            onChanged(contentRating);
          },
        ),
        CheckboxListTile(
          title: const Text('色情'),
          value: contentRating.contains('pornographic'),
          onChanged: (value) {
            if (value == null) return;

            if (!value && contentRating.length == 1) {
              showText(text: '至少选择一项');
              return;
            }
            setState(() =>
                value ? contentRating.add('pornographic') : contentRating.remove('pornographic'));
            onChanged(contentRating);
          },
        ),
      ],
    );
  }
}
