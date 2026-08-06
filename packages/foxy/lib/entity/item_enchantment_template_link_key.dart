import 'package:foxy/entity/item_enchantment_template_entity.dart';

final class ItemEnchantmentTemplateLinkKey {
  final int entry;
  final ItemEnchantmentKind kind;

  const ItemEnchantmentTemplateLinkKey({
    required this.entry,
    required this.kind,
  });

  @override
  int get hashCode => Object.hash(entry, kind);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemEnchantmentTemplateLinkKey &&
          other.entry == entry &&
          other.kind == kind;
}
