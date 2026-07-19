import 'package:foxy/entity/item_enchantment_template_entity.dart';

final class ItemEnchantmentTemplateKey {
  final int entry;
  final int ench;

  const ItemEnchantmentTemplateKey({required this.entry, required this.ench});

  factory ItemEnchantmentTemplateKey.fromEntity(
    ItemEnchantmentTemplateEntity entity,
  ) => ItemEnchantmentTemplateKey(entry: entity.entry, ench: entity.ench);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemEnchantmentTemplateKey &&
          other.entry == entry &&
          other.ench == ench;

  @override
  int get hashCode => Object.hash(entry, ench);
}
