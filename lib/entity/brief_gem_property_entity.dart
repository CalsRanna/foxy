import 'package:foxy/entity/gem_property_key.dart';

class BriefGemPropertyEntity {
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
      id: json['ID'] ?? 0,
      enchantId: json['Enchant_ID'] ?? 0,
      maxCountInv: json['Maxcount_inv'] ?? 0,
      maxCountItem: json['Maxcount_item'] ?? 0,
      type: json['Type'] ?? 0,
    );
  }

  GemPropertyKey get key => GemPropertyKey(id: id);
}
