// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'pickpocketing_loot_template_entity.dart';

final class PickpocketingLootTemplateKey {
  final int entry;
  final int item;

  const PickpocketingLootTemplateKey({required this.entry, required this.item});

  factory PickpocketingLootTemplateKey.fromEntity(
    PickpocketingLootTemplateEntity entity,
  ) {
    return PickpocketingLootTemplateKey(entry: entity.entry, item: entity.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PickpocketingLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hashAll([entry, item]);

  @override
  String toString() {
    return 'PickpocketingLootTemplateKey('
        'entry: $entry, '
        'item: $item'
        ')';
  }
}
