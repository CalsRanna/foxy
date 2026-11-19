import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';

part 'item_enchantment_template_entity.g.dart';

enum ItemEnchantmentKind { randomProperty, randomSuffix }

/// Item enchantment template — maps to the item_enchantment_template table
/// (composite key: entry + ench)

@FoxyFullEntity()
class ItemEnchantmentTemplateEntity with _ItemEnchantmentTemplateEntityMixin {
  @FoxyFullField('entry', key: true)
  final int entry;

  @FoxyFieldMeaning.reference(
    '附魔',
    table: 'foxy.dbc_spell_item_enchantment',
    column: 'ID',
  )
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
