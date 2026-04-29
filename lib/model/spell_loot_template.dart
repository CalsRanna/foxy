/// 法术掉落模板
class SpellLootTemplate {
  int entry = 0;
  int item = 0;
  int reference = 0;
  double chance = 0.0;
  int questRequired = 0;
  int lootMode = 0;
  int groupId = 0;
  int minCount = 0;
  int maxCount = 0;
  String comment = '';

  // 关联字段
  String itemName = '';
  String localeName = '';
  int quality = 0;
  String icon = '';

  SpellLootTemplate();

  factory SpellLootTemplate.fromJson(Map<String, dynamic> json) {
    return SpellLootTemplate()
      ..entry = json['Entry'] ?? json['entry'] ?? 0
      ..item = json['Item'] ?? json['item'] ?? 0
      ..reference = json['Reference'] ?? json['reference'] ?? 0
      ..chance = (json['Chance'] ?? json['chance'] ?? 0.0).toDouble()
      ..questRequired = json['QuestRequired'] ?? json['questRequired'] ?? 0
      ..lootMode = json['LootMode'] ?? json['lootMode'] ?? 0
      ..groupId = json['GroupId'] ?? json['GroudId'] ?? json['groupId'] ?? 0
      ..minCount = json['MinCount'] ?? json['minCount'] ?? 0
      ..maxCount = json['MaxCount'] ?? json['maxCount'] ?? 0
      ..comment = json['Comment'] ?? json['comment'] ?? ''
      ..itemName = json['name'] ?? ''
      ..localeName = json['localeName'] ?? ''
      ..quality = json['Quality'] ?? 0
      ..icon = json['InventoryIcon0'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'Entry': entry,
      'Item': item,
      'Reference': reference,
      'Chance': chance,
      'QuestRequired': questRequired,
      'LootMode': lootMode,
      'GroupId': groupId,
      'MinCount': minCount,
      'MaxCount': maxCount,
      'Comment': comment,
    };
  }
}
