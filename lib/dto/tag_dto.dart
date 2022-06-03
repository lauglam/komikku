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

  factory TagDto.fromSource(Tag source) {
    return TagDto(
      id: source.id,
      name: source.attributes.name.value(),
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
