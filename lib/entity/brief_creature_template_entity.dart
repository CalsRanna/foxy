import 'package:foxy/entity/creature_template_key.dart';

class BriefCreatureTemplateEntity {
  final int entry;
  final String name;
  final String subName;
  final String localeName;
  final String localeSubName;
  final int minLevel;
  final int maxLevel;

  const BriefCreatureTemplateEntity({
    this.entry = 0,
    this.name = '',
    this.subName = '',
    this.localeName = '',
    this.localeSubName = '',
    this.minLevel = 0,
    this.maxLevel = 0,
  });

  factory BriefCreatureTemplateEntity.fromJson(Map<String, dynamic> json) {
    return BriefCreatureTemplateEntity(
      entry: json['entry'] ?? 0,
      name: json['name'] ?? '',
      subName: json['subname'] ?? '',
      localeName: json['Name'] ?? '',
      localeSubName: json['Title'] ?? '',
      minLevel: json['minlevel'] ?? 0,
      maxLevel: json['maxlevel'] ?? 0,
    );
  }

  String get displayName => localeName.isNotEmpty ? localeName : name;
  String get displaySubName =>
      localeSubName.isNotEmpty ? localeSubName : subName;

  CreatureTemplateKey get key => CreatureTemplateKey(entry: entry);
}
