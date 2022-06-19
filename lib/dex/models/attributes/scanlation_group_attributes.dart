import 'package:json_annotation/json_annotation.dart';
import '../localized_string.dart';

part 'scanlation_group_attributes.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ScanlationGroupAttributes {
  /// The name of this group.
  final String name;

  /// Whether this attributes is locked.
  final bool locked;

  /// Whether this attributes is official.
  final bool official;

  /// Whether this attributes is inactive.
  final bool inactive;

  /// Publish delay.
  /// nullable.
  final String? publishDelay;

  /// The alt name of this group.
  /// nullable.
  final List<LocalizedString>? altNames;

  /// Website.
  /// nullable.
  final String? website;

  /// Group server.
  /// nullable.
  final String? ircServer;

  /// Group channel.
  /// nullable.
  final String? ircChannel;

  /// discord.
  /// nullable.
  final String? discord;

  /// The contact email of this manga.
  /// nullable.
  final String? contactEmail;

  /// The description of this manga.
  /// nullable.
  final String? description;

  /// twitter.
  /// nullable.
  final String? twitter;

  /// The updates of this manga.
  /// nullable.
  final String? mangaUpdates;

  /// Focused language.
  /// nullable.
  List<String>? focusedLanguage;

  /// Create date.
  String createdAt;

  /// Update date.
  String updatedAt;

  /// The version of this attributes.
  int version;

  ScanlationGroupAttributes({
    required this.name,
    required this.locked,
    required this.official,
    required this.inactive,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.publishDelay,
    this.altNames,
    this.website,
    this.ircServer,
    this.ircChannel,
    this.discord,
    this.contactEmail,
    this.description,
    this.twitter,
    this.mangaUpdates,
    this.focusedLanguage,
  });

  factory ScanlationGroupAttributes.fromJson(Map<String, dynamic> json) =>
      _$ScanlationGroupAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$ScanlationGroupAttributesToJson(this);
}
