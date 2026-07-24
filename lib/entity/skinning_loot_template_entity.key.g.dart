// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'skinning_loot_template_entity.dart';

final class SkinningLootTemplateKey {
  final int entry;
  final int item;

  const SkinningLootTemplateKey({required this.entry, required this.item});

  factory SkinningLootTemplateKey.fromEntity(
    SkinningLootTemplateEntity entity,
  ) {
    return SkinningLootTemplateKey(entry: entity.entry, item: entity.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SkinningLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hashAll([entry, item]);

  @override
  String toString() {
    return 'SkinningLootTemplateKey('
        'entry: $entry, '
        'item: $item'
        ')';
  }
}
