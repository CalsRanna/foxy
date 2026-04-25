/// 物品附魔模板模型
///
/// item_enchantment_template 表对应模型。
/// 主键为 entry + ench（复合主键）。
/// getByEntry 查询会 LEFT JOIN DBC 表获取附魔名称。
class ItemEnchantmentTemplate {
  int entry = 0;
  int ench = 0;
  double chance = 0;
  int condition1 = 0;
  int condition2 = 0;
  int condition3 = 0;

  // 来自 LEFT JOIN 的 DBC 名称
  String name = '';
  String enchantment1Name = '';
  String enchantment2Name = '';
  String enchantment3Name = '';
  String enchantment4Name = '';
  String enchantment5Name = '';

  ItemEnchantmentTemplate();

  ItemEnchantmentTemplate.fromJson(Map<String, dynamic> json) {
    entry = json['entry'] ?? json['Entry'] ?? 0;
    ench = json['ench'] ?? json['Ench'] ?? 0;
    chance = (json['chance'] ?? json['Chance'] ?? 0).toDouble();
    condition1 = json['condition_1'] ?? json['Condition_1'] ?? 0;
    condition2 = json['condition_2'] ?? json['Condition_2'] ?? 0;
    condition3 = json['condition_3'] ?? json['Condition_3'] ?? 0;
    // JOIN 字段
    name = json['Name_Lang_zhCN'] ?? json['Name'] ?? '';
    enchantment1Name = json['Enchantment_1'] ?? '';
    enchantment2Name = json['Enchantment_2'] ?? '';
    enchantment3Name = json['Enchantment_3'] ?? '';
    enchantment4Name = json['Enchantment_4'] ?? '';
    enchantment5Name = json['Enchantment_5'] ?? '';
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