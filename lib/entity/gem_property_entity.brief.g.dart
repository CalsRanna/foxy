// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefGemPropertyEntity {
  final int id;
  final int enchantId;
  final int maxCountInv;
  final int maxCountItem;
  final int type;

  const BriefGemPropertyEntity({
    this.id = 0,
    this.enchantId = 0,
    this.maxCountInv = 0,
    this.maxCountItem = 0,
    this.type = 0,
  });

  factory BriefGemPropertyEntity.fromJson(Map<String, dynamic> json) {
    return BriefGemPropertyEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      enchantId: (json['Enchant_ID'] as num?)?.toInt() ?? 0,
      maxCountInv: (json['Maxcount_inv'] as num?)?.toInt() ?? 0,
      maxCountItem: (json['Maxcount_item'] as num?)?.toInt() ?? 0,
      type: (json['Type'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
