// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
final class BriefSpellItemEnchantmentConditionEntity {
  final int id;

  const BriefSpellItemEnchantmentConditionEntity({this.id = 0});

  factory BriefSpellItemEnchantmentConditionEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefSpellItemEnchantmentConditionEntity(
      id: (json['ID'] as num?)?.toInt() ?? 0,
    );
  }

  int get key => id;
}
