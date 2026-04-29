class GemProperty {
  final int id;
  final int enchantId;
  final int maxcountInv;
  final int maxcountItem;
  final int type;

  const GemProperty({
    this.id = 0,
    this.enchantId = 0,
    this.maxcountInv = 0,
    this.maxcountItem = 0,
    this.type = 0,
  });

  factory GemProperty.fromJson(Map<String, dynamic> json) {
    return GemProperty(
      id: json['ID'] ?? 0,
      enchantId: json['Enchant_ID'] ?? 0,
      maxcountInv: json['Maxcount_inv'] ?? 0,
      maxcountItem: json['Maxcount_item'] ?? 0,
      type: json['Type'] ?? 0,
    );
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

class BriefGemProperty {
  final int id;
  final int enchantId;
  final int maxcountInv;
  final int type;

  const BriefGemProperty({
    this.id = 0,
    this.enchantId = 0,
    this.maxcountInv = 0,
    this.type = 0,
  });

  factory BriefGemProperty.fromJson(Map<String, dynamic> json) {
    return BriefGemProperty(
      id: json['ID'] ?? 0,
      enchantId: json['Enchant_ID'] ?? 0,
      maxcountInv: json['Maxcount_inv'] ?? 0,
      type: json['Type'] ?? 0,
    );
  }
}
