import 'package:flutter/foundation.dart';
import 'package:foxy/entity/spell_loot_template_entity.dart';

@immutable
final class SpellLootTemplateKey {
  final int entry;
  final int item;

  const SpellLootTemplateKey({required this.entry, required this.item});

  factory SpellLootTemplateKey.fromEntity(SpellLootTemplateEntity value) {
    return SpellLootTemplateKey(entry: value.entry, item: value.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hash(entry, item);
}
