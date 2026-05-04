/// 物品附魔模板 — 对应 item_enchantment_template 表（复合键: entry + ench）
class ItemEnchantmentTemplateEntity {
  final int entry;
  final int ench;
  final double chance;

  const ItemEnchantmentTemplateEntity({
    this.entry = 0,
    this.ench = 0,
    this.chance = 0,
  });

  factory ItemEnchantmentTemplateEntity.fromJson(Map<String, dynamic> json) {
    return ItemEnchantmentTemplateEntity(
      entry: json['entry'] ?? 0,
      ench: json['ench'] ?? 0,
      chance: json['chance'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entry': entry,
      'ench': ench,
      'chance': chance,
    };
  }

  ItemEnchantmentTemplateEntity copyWith({
    int? entry,
    int? ench,
    double? chance,
  }) {
    return ItemEnchantmentTemplateEntity(
      entry: entry ?? this.entry,
      ench: ench ?? this.ench,
      chance: chance ?? this.chance,
    );
  }
}

/// 物品附魔模板列表展示模型（含 LEFT JOIN dbc_spell_item_enchantment + dbc_item_random_properties 的附魔名）
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
  });

  factory BriefItemEnchantmentTemplateEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefItemEnchantmentTemplateEntity(
      entry: json['entry'] ?? 0,
      ench: json['ench'] ?? 0,
      chance: json['chance'] ?? 0.0,
      name: json['Name_Lang_zhCN'] ?? '',
      enchantment1Name: json['Enchantment_1'] ?? '',
      enchantment2Name: json['Enchantment_2'] ?? '',
      enchantment3Name: json['Enchantment_3'] ?? '',
      enchantment4Name: json['Enchantment_4'] ?? '',
      enchantment5Name: json['Enchantment_5'] ?? '',
    );
  }
}
