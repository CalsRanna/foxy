import 'package:flutter/foundation.dart';
import 'package:foxy/entity/loot_template_entity.dart';

@immutable
final class ItemLootTemplateKey {
  final int entry;
  final int item;

  const ItemLootTemplateKey({required this.entry, required this.item});

  factory ItemLootTemplateKey.fromEntity(LootTemplateEntity value) {
    return ItemLootTemplateKey(entry: value.entry, item: value.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hash(entry, item);
}
