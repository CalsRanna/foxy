// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'item_enchantment_template_entity.dart';

final class ItemEnchantmentTemplateKey {
  final int entry;
  final int ench;

  const ItemEnchantmentTemplateKey({required this.entry, required this.ench});

  factory ItemEnchantmentTemplateKey.fromEntity(
    ItemEnchantmentTemplateEntity entity,
  ) {
    return ItemEnchantmentTemplateKey(entry: entity.entry, ench: entity.ench);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemEnchantmentTemplateKey &&
            entry == other.entry &&
            ench == other.ench;
  }

  @override
  int get hashCode => Object.hashAll([entry, ench]);

  @override
  String toString() {
    return 'ItemEnchantmentTemplateKey('
        'entry: $entry, '
        'ench: $ench'
        ')';
  }
}
