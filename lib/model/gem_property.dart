class GemProperty {
  int id = 0;
  int enchantId = 0;
  int maxcountInv = 0;
  int maxcountItem = 0;
  int type = 0;

  GemProperty();

  GemProperty.fromJson(Map<String, dynamic> json) {
    id = json['ID'] ?? 0;
    enchantId = json['Enchant_ID'] ?? 0;
    maxcountInv = json['Maxcount_inv'] ?? 0;
    maxcountItem = json['Maxcount_item'] ?? 0;
    type = json['Type'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Enchant_ID': enchantId,
      'Maxcount_inv': maxcountInv,
      'Maxcount_item': maxcountItem,
      'Type': type,
    };
  }
}
