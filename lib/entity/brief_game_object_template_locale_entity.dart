import 'package:foxy/entity/game_object_template_locale_key.dart';

/// 游戏对象模板本地化列表展示模型。
class BriefGameObjectTemplateLocaleEntity {
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

  GameObjectTemplateLocaleKey get key =>
      GameObjectTemplateLocaleKey(entry: entry, locale: locale);
}
