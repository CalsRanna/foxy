import 'package:flutter/foundation.dart';
import 'package:foxy/entity/loot_template_entity.dart';

@immutable
final class ReferenceLootTemplateKey {
  final int entry;
  final int item;

  const ReferenceLootTemplateKey({required this.entry, required this.item});

  factory ReferenceLootTemplateKey.fromEntity(LootTemplateEntity value) {
    return ReferenceLootTemplateKey(entry: value.entry, item: value.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ReferenceLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hash(entry, item);
}
