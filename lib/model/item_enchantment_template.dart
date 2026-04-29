/// 物品附魔模板模型
///
/// item_enchantment_template 表对应模型。
/// 主键为 entry + ench（复合主键）。
/// getByEntry 查询会 LEFT JOIN DBC 表获取附魔名称。
class ItemEnchantmentTemplate {
  final int entry;
  final int ench;
  final double chance;
  final int condition1;
  final int condition2;
  final int condition3;

  // 来自 LEFT JOIN 的 DBC 名称
  final String name;
  final String enchantment1Name;
  final String enchantment2Name;
  final String enchantment3Name;
  final String enchantment4Name;
  final String enchantment5Name;

  const ItemEnchantmentTemplate({
    this.entry = 0,
    this.ench = 0,
    this.chance = 0,
    this.condition1 = 0,
    this.condition2 = 0,
    this.condition3 = 0,
    this.name = '',
    this.enchantment1Name = '',
    this.enchantment2Name = '',
    this.enchantment3Name = '',
    this.enchantment4Name = '',
    this.enchantment5Name = '',
  });

  factory ItemEnchantmentTemplate.fromJson(Map<String, dynamic> json) {
    return ItemEnchantmentTemplate(
      entry: json['entry'] ?? json['Entry'] ?? 0,
      ench: json['ench'] ?? json['Ench'] ?? 0,
      chance: (json['chance'] ?? json['Chance'] ?? 0).toDouble(),
      condition1: json['condition_1'] ?? json['Condition_1'] ?? 0,
      condition2: json['condition_2'] ?? json['Condition_2'] ?? 0,
      condition3: json['condition_3'] ?? json['Condition_3'] ?? 0,
      name: json['Name_Lang_zhCN'] ?? json['Name'] ?? '',
      enchantment1Name: json['Enchantment_1'] ?? '',
      enchantment2Name: json['Enchantment_2'] ?? '',
      enchantment3Name: json['Enchantment_3'] ?? '',
      enchantment4Name: json['Enchantment_4'] ?? '',
      enchantment5Name: json['Enchantment_5'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'ench': ench,
      'chance': chance,
      'condition_1': condition1,
      'condition_2': condition2,
      'condition_3': condition3,
    };
  }
}
