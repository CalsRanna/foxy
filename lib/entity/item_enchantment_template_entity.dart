import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'item_enchantment_template_entity.g.dart';

enum ItemEnchantmentKind { randomProperty, randomSuffix }

/// 物品附魔模板 — 对应 item_enchantment_template 表（复合键: entry + ench）

@FoxyFilterEntity()
@FoxyFullEntity(table: 'item_enchantment_template')
class ItemEnchantmentTemplateEntity with _ItemEnchantmentTemplateEntityMixin {
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('entry', key: true)
  final int entry;

  @FoxyFullField('ench', key: true)
  final int ench;

  @FoxyFullField('chance')
  final double chance;

  const ItemEnchantmentTemplateEntity({
    this.entry = 0,
    this.ench = 0,
    this.chance = 0,
  });

  factory ItemEnchantmentTemplateEntity.fromJson(Map<String, dynamic> json) =>
      _ItemEnchantmentTemplateEntityMixin.fromJson(json);
}
