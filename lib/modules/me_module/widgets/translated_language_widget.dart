import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/core/utils/icons.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/data/hive.dart';
import 'package:komikku/modules/home_module/controller.dart';

import 'icon_button_widget.dart';

/// 章节翻译
class TranslatedLanguageWidget extends StatelessWidget {
  const TranslatedLanguageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    final selected = RxList<String>(HiveDatabase.translatedLanguage);

    /// Content of alert dialog
    final alertContent = SizedBox(
      width: 280,
      height: 500,
      child: Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          prototypeItem: _placeholder,
          itemCount: _localizedStringMap.length,
          itemBuilder: (context, index) {
            final currentKey = _localizedStringMap.keys.elementAt(index);
            final currentValue = _localizedStringMap.values.elementAt(index);
            return Obx(
              () => CheckboxListTile(
                title: Text(currentValue),
                value: selected.contains(currentKey),
                onChanged: (value) {
                  if (value == null) return;
                  value ? selected.add(currentKey) : selected.remove(currentKey);
                },
              ),
            );
          },
        ),
      ),
    );

    return IconTextButtonWidget(
      text: '章节语言',
      icon: TaoIcons.comment,
      onPressed: () => showAlertDialog(
        title: '章节语言',
        content: alertContent,
        // translatedLanguage can be empty
        onConfirm: () {
          HiveDatabase.translatedLanguage = selected;
          // 刷新首页
          controller.refreshController.requestRefresh();
        },
      ),
    );
  }

  static const _placeholder = CheckboxListTile(title: Text(''), value: true, onChanged: null);

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
