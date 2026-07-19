class BriefSpellItemEnchantmentConditionEntity {
  final int id;

  const BriefSpellItemEnchantmentConditionEntity({this.id = 0});

  factory BriefSpellItemEnchantmentConditionEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefSpellItemEnchantmentConditionEntity(id: json['ID'] ?? 0);
  }

  int get key => id;
}
