enum ItemEnchantmentKind { randomProperty, randomSuffix }

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
      chance: ((json['chance'] ?? 0) as num).toDouble(),
    );
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

  Map<String, dynamic> toJson() {
    return {'entry': entry, 'ench': ench, 'chance': chance};
  }
}
