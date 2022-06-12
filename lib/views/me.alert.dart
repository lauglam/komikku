part of 'me.dart';

/// 内容分级
class _ContentRating extends StatefulWidget {
  const _ContentRating({required this.selectedContentRating, required this.onChanged});

  final List<String> selectedContentRating;
  final void Function(List<String> value) onChanged;

  @override
  State<_ContentRating> createState() => _ContentRatingState();
}

class _ContentRatingState extends State<_ContentRating> {
  late final selectedContentRating = widget.selectedContentRating;
  late final onChanged = widget.onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          prototypeItem:
              CheckboxListTile(title: const Text(''), value: true, onChanged: (value) {}),
          itemCount: _contentRatingMap.length,
          itemBuilder: (context, index) {
            final currentKey = _contentRatingMap.keys.elementAt(index);
            final currentValue = _contentRatingMap.values.elementAt(index);
            return CheckboxListTile(
              title: Text(currentValue),
              value: selectedContentRating.contains(currentKey),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  value
                      ? selectedContentRating.add(currentKey)
                      : selectedContentRating.remove(currentKey);
                  widget.onChanged(selectedContentRating);
                });
              },
            );
          },
        ),
      ),
    );
  }

  static const _contentRatingMap = {
    'safe': '安全的',
    'suggestive': '暗示的',
    'erotica': '涉黄的',
    'pornographic': '色情的'
  };
}

/// 图片质量
class _DataSaver extends StatefulWidget {
  const _DataSaver({required this.selectedDataSaver, required this.onChanged});

  final bool selectedDataSaver;
  final void Function(bool value) onChanged;

  @override
  State<_DataSaver> createState() => _DataSaverState();
}

class _DataSaverState extends State<_DataSaver> {
  late bool selectedDataSaver = widget.selectedDataSaver;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: const Text('图片压缩'),
      value: selectedDataSaver,
      onChanged: (value) {
        if (value == null) return;
        setState(() {
          selectedDataSaver = value;
          widget.onChanged(selectedDataSaver);
        });
      },
    );
  }
}

/// 章节翻译
class _TranslatedLanguage extends StatefulWidget {
  const _TranslatedLanguage({required this.selectedLanguage, required this.onChanged});

  final List<String> selectedLanguage;
  final void Function(List<String>) onChanged;

  @override
  State<_TranslatedLanguage> createState() => _TranslatedLanguageState();
}

class _TranslatedLanguageState extends State<_TranslatedLanguage> {
  late List<String> selectedLanguage = widget.selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 500,
      child: Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          prototypeItem:
              CheckboxListTile(title: const Text(''), value: true, onChanged: (value) {}),
          itemCount: _localizedStringMap.length,
          itemBuilder: (context, index) {
            final currentKey = _localizedStringMap.keys.elementAt(index);
            final currentValue = _localizedStringMap.values.elementAt(index);
            return CheckboxListTile(
              title: Text(currentValue),
              value: selectedLanguage.contains(currentKey),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  value ? selectedLanguage.add(currentKey) : selectedLanguage.remove(currentKey);
                  widget.onChanged(selectedLanguage);
                });
              },
            );
          },
        ),
      ),
    );
  }

  static const _localizedStringMap = {
    'en': 'English',
    'ar': 'Arabic',
    'bn': 'Bengali',
    'bg': 'Bulgarian',
    'my': 'Burmese',
    'ca': 'Catalan',
    'zh': 'Chinese-Simplified',
    'zh-hk': 'Chinese-Traditional',
    'zh-ro': 'Chinese-Roman',
    'hr': 'Croatian',
    'cs': 'Czech',
    'da': 'Danish',
    'nl': 'Dutch',
    'eo': 'Esperanto',
    'et': 'Estonian',
    'tl': 'Filipino',
    'fi': 'Finnish',
    'fr': 'French',
    'de': 'German',
    'el': 'Greek',
    'he': 'Hebrew',
    'hi': 'Hindi',
    'hu': 'Hungarian',
    'id': 'Indonesian',
    'it': 'Italian',
    'ja': 'Japanese',
    'ja-ro': 'Japanese-Roman',
    'ko': 'Korean',
    'ko-ro': 'Korean-Roman',
    'la': 'Latin',
    'lt': 'Lithuanian',
    'ms': 'Malay',
    'mn': 'Mongolian',
    'ne': 'Nepali',
    'no': 'Norwegian',
    'fa': 'Persian',
    'pl': 'Polish',
    'pt': 'Portuguese',
    'pt-br': 'Portuguese-Brazilian',
    'ro': 'Romanian',
    'ru': 'Russian',
    'sr': 'Serbian',
    'es': 'Spanish',
    'es-la': 'Spanish-LATAM',
    'sv': 'Swedish',
    'th': 'Thai',
    'tr': 'Turkish',
    'uk': 'Ukrainian',
    'vi': 'Vietnamese',
  };
}
