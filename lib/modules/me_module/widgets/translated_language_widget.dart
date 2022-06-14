import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 章节翻译
class TranslatedLanguageWidget extends StatelessWidget {
  final List<String> selectedLanguage;
  final void Function(List<String>) onChanged;

  const TranslatedLanguageWidget({
    Key? key,
    required this.selectedLanguage,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedLanguageRx = RxList<String>(selectedLanguage);
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
            return Obx(
              () => CheckboxListTile(
                title: Text(currentValue),
                value: selectedLanguageRx.contains(currentKey),
                onChanged: (value) {
                  if (value == null) return;
                  value
                      ? selectedLanguageRx.add(currentKey)
                      : selectedLanguageRx.remove(currentKey);
                  onChanged(selectedLanguageRx);
                },
              ),
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
