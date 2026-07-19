import 'package:foxy/entity/creature_template_locale_key.dart';

/// 生物模板本地化列表展示模型。
class BriefCreatureTemplateLocaleEntity {
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

  CreatureTemplateLocaleKey get key =>
      CreatureTemplateLocaleKey(entry: entry, locale: locale);
}
