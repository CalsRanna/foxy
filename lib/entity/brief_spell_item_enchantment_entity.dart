class BriefSpellItemEnchantmentEntity {
  final int id;
  final String nameLangZhCN;
  final int charges;
  final int effect0;
  final int effect1;
  final int effect2;

  const BriefSpellItemEnchantmentEntity({
    this.id = 0,
    this.nameLangZhCN = '',
    this.charges = 0,
    this.effect0 = 0,
    this.effect1 = 0,
    this.effect2 = 0,
  });

  factory BriefSpellItemEnchantmentEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellItemEnchantmentEntity(
      id: json['ID'] ?? 0,
      nameLangZhCN: json['Name_lang_zhCN'] ?? '',
      charges: json['Charges'] ?? 0,
      effect0: json['Effect0'] ?? 0,
      effect1: json['Effect1'] ?? 0,
      effect2: json['Effect2'] ?? 0,
    );
  }

  int get key => id;
}
