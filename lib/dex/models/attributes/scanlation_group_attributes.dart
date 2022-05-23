import 'package:komikku/dex/models/localized_string.dart';

class ScanlationGroupAttributes {
  String name;
  bool locked;
  bool official;
  bool inactive;
  String? publishDelay;
  List<LocalizedString>? altNames;
  String? website;
  String? ircServer;
  String? ircChannel;
  String? discord;
  String? contactEmail;
  String? description;
  String? twitter;
  String? mangaUpdates;
  List<String>? focusedLanguage;

  String createdAt;
  String updatedAt;
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
      ScanlationGroupAttributes(
        name: json['name'] as String,
        locked: json['locked'] as bool,
        official: json['official'] as bool,
        inactive: json['inactive'] as bool,
        publishDelay: json['publishDelay'] as String?,
        createdAt: json['createdAt'] as String,
        updatedAt: json['updatedAt'] as String,
        version: json['version'] as int,
        altNames: (json['altNames'] as List<dynamic>?)
            ?.map((e) => LocalizedString.fromJson(e as Map<String, dynamic>))
            .toList(),
        website: json['website'] as String?,
        ircServer: json['ircServer'] as String?,
        ircChannel: json['ircChannel'] as String?,
        discord: json['discord'] as String?,
        contactEmail: json['contactEmail'] as String?,
        description: json['description'] as String?,
        twitter: json['twitter'] as String?,
        mangaUpdates: json['mangaUpdates'] as String?,
        focusedLanguage:
            (json['focusedLanguage'] as List<dynamic>?)?.map((e) => e as String).toList(),
      );

  Map<String, dynamic> toJson() {
    final val = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null) {
        val[key] = value;
      }
    }

    val['name'] = name;
    val['locked'] = locked;
    val['official'] = official;
    val['inactive'] = inactive;
    val['createdAt'] = createdAt;
    val['updatedAt'] = updatedAt;
    val['version'] = version;
    writeNotNull('publishDelay', publishDelay);
    writeNotNull('altNames', altNames);
    writeNotNull('website', website);
    writeNotNull('ircServer', ircServer);
    writeNotNull('ircChannel', ircChannel);
    writeNotNull('discord', discord);
    writeNotNull('contactEmail', contactEmail);
    writeNotNull('description', description);
    writeNotNull('twitter', twitter);
    writeNotNull('mangaUpdates', mangaUpdates);
    writeNotNull('focusedLanguage', focusedLanguage);
    return val;
  }
}
