import 'package:foxy/entity/item_enchantment_template_entity.dart';

final class ItemEnchantmentTemplateParentKey {
  final int entry;
  final ItemEnchantmentKind kind;

  const ItemEnchantmentTemplateParentKey({
    required this.entry,
    required this.kind,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemEnchantmentTemplateParentKey &&
          other.entry == entry &&
          other.kind == kind;

  @override
  int get hashCode => Object.hash(entry, kind);
}
