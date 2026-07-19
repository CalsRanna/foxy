import 'package:foxy/entity/item_template_locale_key.dart';

/// 物品模板本地化列表展示模型。
class BriefItemTemplateLocaleEntity {
  final int id;
  final String locale;
  final String name;

  const BriefItemTemplateLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.name = '',
  });

  factory BriefItemTemplateLocaleEntity.fromJson(Map<String, dynamic> json) {
    return BriefItemTemplateLocaleEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      locale: json['locale']?.toString() ?? 'zhCN',
      name: json['Name']?.toString() ?? '',
    );
  }

  ItemTemplateLocaleKey get key =>
      ItemTemplateLocaleKey(id: id, locale: locale);
}
