/// 物品附魔模板 — 对应 item_enchantment_template 表（复合键: entry + ench）
class ItemEnchantmentTemplateEntity {
  final int entry;
  final int ench;
  final double chance;
  final int condition1;
  final int condition2;
  final int condition3;

  const ItemEnchantmentTemplateEntity({
    this.entry = 0,
    this.ench = 0,
    this.chance = 0,
    this.condition1 = 0,
    this.condition2 = 0,
    this.condition3 = 0,
  });

  factory ItemEnchantmentTemplateEntity.fromJson(Map<String, dynamic> json) {
    return ItemEnchantmentTemplateEntity(
      entry: json['entry'] ?? 0,
      ench: json['ench'] ?? 0,
      chance: (json['chance'] as num?)?.toDouble() ?? 0.0,
      condition1: json['condition_1'] ?? 0,
      condition2: json['condition_2'] ?? 0,
      condition3: json['condition_3'] ?? 0,
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

/// 物品附魔模板列表展示模型（含 LEFT JOIN dbc_spell_item_enchantment + dbc_item_random_properties 的附魔名）
class BriefItemEnchantmentTemplate {
  final int entry;
  final int ench;
  final double chance;
  final int condition1;
  final int condition2;
  final int condition3;
  final String name;
  final String enchantment1Name;
  final String enchantment2Name;
  final String enchantment3Name;
  final String enchantment4Name;
  final String enchantment5Name;

  const BriefItemEnchantmentTemplate({
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

  factory BriefItemEnchantmentTemplate.fromJson(Map<String, dynamic> json) {
    return BriefItemEnchantmentTemplate(
      entry: json['entry'] ?? 0,
      ench: json['ench'] ?? 0,
      chance: (json['chance'] as num?)?.toDouble() ?? 0.0,
      condition1: json['condition_1'] ?? 0,
      condition2: json['condition_2'] ?? 0,
      condition3: json['condition_3'] ?? 0,
      name: json['Name_Lang_zhCN'] ?? '',
      enchantment1Name: json['Enchantment_1'] ?? '',
      enchantment2Name: json['Enchantment_2'] ?? '',
      enchantment3Name: json['Enchantment_3'] ?? '',
      enchantment4Name: json['Enchantment_4'] ?? '',
      enchantment5Name: json['Enchantment_5'] ?? '',
    );
  }
}
