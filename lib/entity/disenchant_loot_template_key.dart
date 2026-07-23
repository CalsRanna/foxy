import 'package:flutter/foundation.dart';
import 'package:foxy/entity/loot_template_entity.dart';

@immutable
final class DisenchantLootTemplateKey {
  final int entry;
  final int item;

  const DisenchantLootTemplateKey({required this.entry, required this.item});

  factory DisenchantLootTemplateKey.fromEntity(LootTemplateEntity value) {
    return DisenchantLootTemplateKey(entry: value.entry, item: value.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DisenchantLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hash(entry, item);
}
