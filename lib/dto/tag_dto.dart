import 'package:komikku/database/hive.dart';
import 'package:komikku/dex/models/tag.dart';

class TagDto {
  final String id;
  final String name;
  final String group;

  TagDto({
    required this.id,
    required this.name,
    required this.group,
  });

  factory TagDto.fromDex(Tag source) {
    final nameMap = source.attributes.name.toJson();
    var name = nameMap.values.first;
    for (var entry in nameMap.entries) {
      if (!HiveDatabase.translatedLanguage.contains(entry.key)) continue;
      name = entry.value;
    }

    return TagDto(
      id: source.id,
      name: name,
      group: source.attributes.group,
    );
  }

  factory TagDto.fromJson(Map<String, dynamic> json) => TagDto(
        id: json['id'] as String,
        name: json['name'] as String,
        group: json['group'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'group': group,
      };
}
