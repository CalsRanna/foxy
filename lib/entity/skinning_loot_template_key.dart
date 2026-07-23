import 'package:flutter/foundation.dart';
import 'package:foxy/entity/skinning_loot_template_entity.dart';

@immutable
final class SkinningLootTemplateKey {
  final int entry;
  final int item;

  const SkinningLootTemplateKey({required this.entry, required this.item});

  factory SkinningLootTemplateKey.fromEntity(SkinningLootTemplateEntity value) {
    return SkinningLootTemplateKey(entry: value.entry, item: value.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SkinningLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hash(entry, item);
}
