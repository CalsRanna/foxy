// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'disenchant_loot_template_entity.dart';

final class DisenchantLootTemplateKey {
  final int entry;
  final int item;

  const DisenchantLootTemplateKey({required this.entry, required this.item});

  factory DisenchantLootTemplateKey.fromEntity(
    DisenchantLootTemplateEntity entity,
  ) {
    return DisenchantLootTemplateKey(entry: entity.entry, item: entity.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is DisenchantLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hashAll([entry, item]);

  @override
  String toString() {
    return 'DisenchantLootTemplateKey('
        'entry: $entry, '
        'item: $item'
        ')';
  }
}
