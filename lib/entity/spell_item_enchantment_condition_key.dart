import 'package:foxy/entity/spell_item_enchantment_condition_entity.dart';

class SpellItemEnchantmentConditionKey {
  final int id;

  const SpellItemEnchantmentConditionKey({required this.id});

  factory SpellItemEnchantmentConditionKey.fromEntity(
    SpellItemEnchantmentConditionEntity entity,
  ) => SpellItemEnchantmentConditionKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellItemEnchantmentConditionKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
