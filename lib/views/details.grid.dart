part of 'details.dart';

/// 漫画栅格
class _DetailsGrid extends StatelessWidget {
  const _DetailsGrid(this.chapters, {Key? key}) : super(key: key);

  final List<ChapterDto> chapters;

  @override
  Widget build(BuildContext context) {
    var itemsMap = chapters.groupListsBy((value) => value.chapter);

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 2,
      ),
      itemCount: itemsMap.length,
      // 必须设置shrinkWrap & physics
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, chapterIndex) {
        var values = itemsMap.values.elementAt(chapterIndex);

        // 因为排序的原因，所以要明确上一章到底位于数组的前一个还是后一个
        // 如果是倒序，则反转
        var ascIndex = chapterIndex;
        var ascArrays = itemsMap.values;
        if (chapters.length > 2 && chapters[0].readableAt.isAfter(chapters[1].readableAt)) {
          ascIndex = itemsMap.length - chapterIndex - 1;
          ascArrays = itemsMap.values.toList().reversed.toList();
        }

        // 弹出模态框按钮
        if (values.length > 1) {
          return OutlinedButton(
            child: Text(
              '${values[0].chapter ?? chapterIndex}',
              style: const TextStyle(color: Colors.black54),
            ),
            onPressed: () async => await showBottomModal(
              context: context,
              title: '第 ${values[0].chapter ?? chapterIndex} 章',
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: values.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Material(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.black12,
                      clipBehavior: Clip.antiAlias,
                      child: BottomModalItem(
                        title: '${values[index].title ?? index}',
                        subtitle1: timeAgo(values[index].readableAt),
                        subtitle2: values[index].scanlationGroup ?? '',
                        subtitle3: values[index].uploader ?? '',
                        subtitle4: '共 ${values[index].pages} 页',
                        onTap: () {
                          // 先关闭模态框
                          Navigator.pop(context);

                          // 跳转到阅读页面
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Reading(
                                id: values[index].id,
                                index: ascIndex,
                                arrays: ascArrays,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        // 单独按钮
        return OutlinedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Reading(
                id: values[0].id,
                index: ascIndex,
                arrays: ascArrays,
              ),
            ),
          ),
          child: Text(
            '${values[0].chapter ?? chapterIndex}',
            style: const TextStyle(color: Colors.black54),
          ),
        );
      },
    );
  }
}
