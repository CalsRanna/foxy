// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'prospecting_loot_template_entity.dart';

final class ProspectingLootTemplateKey {
  final int entry;
  final int item;

  const ProspectingLootTemplateKey({required this.entry, required this.item});

  factory ProspectingLootTemplateKey.fromEntity(
    ProspectingLootTemplateEntity entity,
  ) {
    return ProspectingLootTemplateKey(entry: entity.entry, item: entity.item);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ProspectingLootTemplateKey &&
            entry == other.entry &&
            item == other.item;
  }

  @override
  int get hashCode => Object.hashAll([entry, item]);

  @override
  String toString() {
    return 'ProspectingLootTemplateKey('
        'entry: $entry, '
        'item: $item'
        ')';
  }
}
