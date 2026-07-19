import 'package:foxy/entity/spell_item_enchantment_entity.dart';

class SpellItemEnchantmentKey {
  final int id;

  const SpellItemEnchantmentKey({required this.id});

  factory SpellItemEnchantmentKey.fromEntity(
    SpellItemEnchantmentEntity entity,
  ) {
    return SpellItemEnchantmentKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellItemEnchantmentKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
