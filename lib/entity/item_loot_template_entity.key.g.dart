// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'item_loot_template_entity.dart';

final class ItemLootTemplateKey {
  final int entry;
  final int item;

  const ItemLootTemplateKey({required this.entry, required this.item});

  factory ItemLootTemplateKey.fromEntity(ItemLootTemplateEntity entity) {
    return ItemLootTemplateKey(entry: entity.entry, item: entity.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hashAll([entry, item]);

  @override
  String toString() {
    return 'ItemLootTemplateKey('
        'entry: $entry, '
        'item: $item'
        ')';
  }
}
