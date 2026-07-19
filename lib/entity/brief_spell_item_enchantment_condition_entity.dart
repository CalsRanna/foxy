import 'package:foxy/entity/spell_item_enchantment_condition_key.dart';

class BriefSpellItemEnchantmentConditionEntity {
  final int id;

  const BriefSpellItemEnchantmentConditionEntity({this.id = 0});

  factory BriefSpellItemEnchantmentConditionEntity.fromJson(
    Map<String, dynamic> json,
  ) {
    return BriefSpellItemEnchantmentConditionEntity(id: json['ID'] ?? 0);
  }

  SpellItemEnchantmentConditionKey get key =>
      SpellItemEnchantmentConditionKey(id: id);
}
