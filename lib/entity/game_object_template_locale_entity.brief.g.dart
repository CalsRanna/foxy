// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'game_object_template_locale_entity.key.g.dart';

final class BriefGameObjectTemplateLocaleEntity {
  final int entry;
  final String locale;
  final String name;
  final String castBarCaption;

  const BriefGameObjectTemplateLocaleEntity({
    this.entry = 0,
    this.locale = '',
    this.name = '',
    this.castBarCaption = '',
  });

  factory BriefGameObjectTemplateLocaleEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefGameObjectTemplateLocaleEntity(
      entry: (json['entry'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      castBarCaption: json['castBarCaption']?.toString() ?? '',
    );
  }

  GameObjectTemplateLocaleKey get key {
    return GameObjectTemplateLocaleKey(entry: entry, locale: locale);
  }
}
