import 'package:flutter/foundation.dart';
import 'package:foxy/entity/prospecting_loot_template_entity.dart';

@immutable
final class ProspectingLootTemplateKey {
  final int entry;
  final int item;

  const ProspectingLootTemplateKey({required this.entry, required this.item});

  factory ProspectingLootTemplateKey.fromEntity(
    ProspectingLootTemplateEntity value,
  ) {
    return ProspectingLootTemplateKey(entry: value.entry, item: value.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ProspectingLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hash(entry, item);
}
