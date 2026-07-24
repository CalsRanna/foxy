// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'npc_vendor_entity.dart';

final class NpcVendorKey {
  final int entry;
  final int item;
  final int extendedCost;

  const NpcVendorKey({
    required this.entry,
    required this.item,
    required this.extendedCost,
  });

  factory NpcVendorKey.fromEntity(NpcVendorEntity entity) {
    return NpcVendorKey(
      entry: entity.entry,
      item: entity.item,
      extendedCost: entity.extendedCost,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NpcVendorKey &&
            entry == other.entry &&
            item == other.item &&
            extendedCost == other.extendedCost;
  }

  @override
  int get hashCode => Object.hashAll([entry, item, extendedCost]);

  @override
  String toString() {
    return 'NpcVendorKey('
        'entry: $entry, '
        'item: $item, '
        'extendedCost: $extendedCost'
        ')';
  }
}
