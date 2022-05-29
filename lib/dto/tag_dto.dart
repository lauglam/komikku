import 'package:komikku/dex/models/tag.dart';

class TagDto {
  String id;
  String name;
  String group;

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
}
