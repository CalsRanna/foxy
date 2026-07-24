import 'package:foxy/entity/item_enchantment_template_entity.dart';

/// 物品附魔模板列表展示模型（含关联 DBC 的附魔名）。
class BriefItemEnchantmentTemplateEntity {
  final int entry;
  final int ench;
  final double chance;
  final String name;
  final String enchantment1Name;
  final String enchantment2Name;
  final String enchantment3Name;
  final String enchantment4Name;
  final String enchantment5Name;
  final ItemEnchantmentKind kind;
  final int itemCount;

  const BriefItemEnchantmentTemplateEntity({
    this.entry = 0,
    this.ench = 0,
    this.chance = 0,
    this.name = '',
    this.enchantment1Name = '',
    this.enchantment2Name = '',
    this.enchantment3Name = '',
    this.enchantment4Name = '',
    this.enchantment5Name = '',
    this.kind = ItemEnchantmentKind.randomProperty,
    this.itemCount = 0,
  });

  factory BriefItemEnchantmentTemplateEntity.fromJson(
    Map<String, dynamic> json,
  ) => BriefItemEnchantmentTemplateEntity(
    entry: json['entry'] ?? 0,
    ench: json['ench'] ?? 0,
    chance: ((json['chance'] ?? 0) as num).toDouble(),
    name: json['name'] ?? '',
    enchantment1Name: json['Enchantment_1'] ?? '',
    enchantment2Name: json['Enchantment_2'] ?? '',
    enchantment3Name: json['Enchantment_3'] ?? '',
    enchantment4Name: json['Enchantment_4'] ?? '',
    enchantment5Name: json['Enchantment_5'] ?? '',
    kind: json['kind'] == ItemEnchantmentKind.randomSuffix.name
        ? ItemEnchantmentKind.randomSuffix
        : ItemEnchantmentKind.randomProperty,
    itemCount: json['ItemCount'] ?? 0,
  );

  ItemEnchantmentTemplateKey get key =>
      ItemEnchantmentTemplateKey(entry: entry, ench: ench);
}
