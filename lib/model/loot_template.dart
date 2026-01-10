/// 掉落模板
class LootTemplate {
  int entry = 0;
  int item = 0;
  double chance = 0;
  int minCount = 1;
  int maxCount = 1;

  LootTemplate();

  LootTemplate.fromJson(Map<String, dynamic> json) {
    entry = json['Entry'] ?? json['entry'] ?? 0;
    item = json['Item'] ?? json['item'] ?? 0;
    chance = (json['Chance'] ?? json['chance'] ?? 0).toDouble();
    minCount = json['MinCount'] ?? json['mincount'] ?? 1;
    maxCount = json['MaxCount'] ?? json['maxcount'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    return {
      'Entry': entry,
      'Item': item,
      'Chance': chance,
      'MinCount': minCount,
      'MaxCount': maxCount,
    };
  }
}
