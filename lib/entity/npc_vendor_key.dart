import 'package:flutter/foundation.dart';
import 'package:foxy/entity/npc_vendor_entity.dart';

@immutable
final class NpcVendorKey {
  final int entry;
  final int item;
  final int extendedCost;

  const NpcVendorKey({
    required this.entry,
    required this.item,
    required this.extendedCost,
  });

  factory NpcVendorKey.fromEntity(NpcVendorEntity value) {
    return NpcVendorKey(
      entry: value.entry,
      item: value.item,
      extendedCost: value.extendedCost,
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
  int get hashCode => Object.hash(entry, item, extendedCost);
}
