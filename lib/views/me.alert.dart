part of 'me.dart';

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

/// 图片质量
class _DataSaver extends StatefulWidget {
  const _DataSaver({required this.dataSaver, required this.onChanged});

  final bool dataSaver;
  final void Function(bool value) onChanged;

  @override
  State<_DataSaver> createState() => _DataSaverState();
}

class _DataSaverState extends State<_DataSaver> {
  late bool dataSaver = widget.dataSaver;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: const Text('图片压缩'),
          value: dataSaver,
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              dataSaver = value;
              widget.onChanged(dataSaver);
            });
          },
        ),
      ],
    );
  }
}
