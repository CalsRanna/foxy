// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefSpellItemEnchantmentEntity {
  final int id;
  final int charges;
  final int effect0;
  final int effect1;
  final int effect2;
  final String nameLangZhCN;

  const BriefSpellItemEnchantmentEntity({
    this.id = 0,
    this.charges = 0,
    this.effect0 = 0,
    this.effect1 = 0,
    this.effect2 = 0,
    this.nameLangZhCN = '',
  });

  factory BriefSpellItemEnchantmentEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellItemEnchantmentEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      charges: (json['Charges'] as num?)?.toInt() ?? 0,
      effect0: (json['Effect0'] as num?)?.toInt() ?? 0,
      effect1: (json['Effect1'] as num?)?.toInt() ?? 0,
      effect2: (json['Effect2'] as num?)?.toInt() ?? 0,
      nameLangZhCN: json['Name_lang_zhCN']?.toString() ?? '',
    );
  }

  int get key => id;
}
