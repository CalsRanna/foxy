// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'creature_template_locale_entity.key.g.dart';

final class BriefCreatureTemplateLocaleEntity {
  final int entry;
  final String locale;
  final String name;
  final String title;

  const BriefCreatureTemplateLocaleEntity({
    this.entry = 0,
    this.locale = '',
    this.name = '',
    this.title = '',
  });

  factory BriefCreatureTemplateLocaleEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefCreatureTemplateLocaleEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? '',
      name: json['Name']?.toString() ?? '',
      title: json['Title']?.toString() ?? '',
    );
  }

  CreatureTemplateLocaleKey get key {
    return CreatureTemplateLocaleKey(entry: entry, locale: locale);
  }
}
