import 'package:flutter/foundation.dart';
import 'package:foxy/entity/loot_template_entity.dart';

@immutable
final class MillingLootTemplateKey {
  final int entry;
  final int item;

  const MillingLootTemplateKey({required this.entry, required this.item});

  factory MillingLootTemplateKey.fromEntity(LootTemplateEntity value) {
    return MillingLootTemplateKey(entry: value.entry, item: value.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MillingLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hash(entry, item);
}
