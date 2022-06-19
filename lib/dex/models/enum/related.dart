import 'package:json_annotation/json_annotation.dart';

enum Related {
  /// A monochrome variant of this manga.
  monochrome,

  /// A colored variant of this manga.
  colored,

  /// The original version of this manga before its official serialization.
  preserialization,

  /// The official serialization of this manga.
  serialization,

  /// The previous entry in the same series.
  prequel,

  /// The next entry in the same series.
  sequel,

  /// The original narrative this manga is based on.
  @JsonValue('main_story')
  mainStory,

  /// A side work contemporaneous with the narrative of this manga.
  @JsonValue('side_story')
  sideStory,

  /// The original work this spin-off manga has been adapted from.
  @JsonValue('adapted_from')
  adaptedFrom,

  /// An official derivative work based on this manga.
  @JsonValue('spin_off')
  spinOff,

  /// The original work this self-published derivative manga is based on.
  @JsonValue('based_on')
  basedOn,

  /// A self-published derivative work based on this manga.
  @JsonValue('doujinshi')
  douJinShi,

  /// A manga based on the same intellectual property as this manga.
  @JsonValue('same_franchise')
  sameFranchise,

  /// A manga taking place in the same fictional world as this manga.
  @JsonValue('shared_universe')
  sharedUniverse,

  /// An alternative take of the story in this manga.
  @JsonValue('alternate_story')
  alternateStory,

  /// A different version of this manga with no other specific distinction.
  @JsonValue('alternate_version')
  alternateVersion,
}
