import 'package:flutter/foundation.dart';
import 'package:foxy/entity/loot_template_entity.dart';

@immutable
final class PickpocketingLootTemplateKey {
  final int entry;
  final int item;

  const PickpocketingLootTemplateKey({required this.entry, required this.item});

  factory PickpocketingLootTemplateKey.fromEntity(LootTemplateEntity value) {
    return PickpocketingLootTemplateKey(entry: value.entry, item: value.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PickpocketingLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hash(entry, item);
}
