import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'item_template_locale_entity.g.dart';

/// item_template_locale 表模型（1:N locale，复合主键 ID + Locale）

@FoxyBriefEntity()
@FoxyFullEntity(table: 'item_template_locale')
class ItemTemplateLocaleEntity with _ItemTemplateLocaleEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('locale', key: true)
  final String locale;

  @FoxyBriefField()
  @FoxyFullField('Name')
  final String name;

  @FoxyFullField('Description')
  final String description;

  @FoxyFullField('VerifiedBuild')
  final int verifiedBuild;

  const ItemTemplateLocaleEntity({
    this.id = 0,
    this.locale = 'zhCN',
    this.name = '',
    this.description = '',
    this.verifiedBuild = 0,
  });

  factory ItemTemplateLocaleEntity.fromJson(Map<String, dynamic> json) =>
      _ItemTemplateLocaleEntityMixin.fromJson(json);
}
