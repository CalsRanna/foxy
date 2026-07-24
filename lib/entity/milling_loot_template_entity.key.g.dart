// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'milling_loot_template_entity.dart';

final class MillingLootTemplateKey {
  final int entry;
  final int item;

  const MillingLootTemplateKey({required this.entry, required this.item});

  factory MillingLootTemplateKey.fromEntity(MillingLootTemplateEntity entity) {
    return MillingLootTemplateKey(entry: entity.entry, item: entity.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is MillingLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hashAll([entry, item]);

  @override
  String toString() {
    return 'MillingLootTemplateKey('
        'entry: $entry, '
        'item: $item'
        ')';
  }
}
