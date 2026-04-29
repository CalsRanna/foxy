class GemPropertyEntity {
  final int id;
  final int enchantId;
  final int maxCountInv;
  final int maxCountItem;
  final int type;

  const GemPropertyEntity({
    this.id = 0,
    this.enchantId = 0,
    this.maxCountInv = 0,
    this.maxCountItem = 0,
    this.type = 0,
  });

  factory GemPropertyEntity.fromJson(Map<String, dynamic> json) {
    return GemPropertyEntity(
      id: json['ID'] ?? 0,
      enchantId: json['Enchant_ID'] ?? 0,
      maxCountInv: json['Maxcount_inv'] ?? 0,
      maxCountItem: json['Maxcount_item'] ?? 0,
      type: json['Type'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Enchant_ID': enchantId,
      'Maxcount_inv': maxCountInv,
      'Maxcount_item': maxCountItem,
      'Type': type,
    };
  }
}

class BriefGemPropertyEntity {
  final int id;
  final int enchantId;
  final int maxCountInv;
  final int type;

  const BriefGemPropertyEntity({
    this.id = 0,
    this.enchantId = 0,
    this.maxCountInv = 0,
    this.type = 0,
  });

  factory BriefGemPropertyEntity.fromJson(Map<String, dynamic> json) {
    return BriefGemPropertyEntity(
      id: json['ID'] ?? 0,
      enchantId: json['Enchant_ID'] ?? 0,
      maxCountInv: json['Maxcount_inv'] ?? 0,
      type: json['Type'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Enchant_ID': enchantId,
      'Maxcount_inv': maxCountInv,
      'Type': type,
    };
  }
}
