import 'package:foxy/entity/item_extended_cost_entity.dart';

class ItemExtendedCostKey {
  final int id;

  const ItemExtendedCostKey({required this.id});

  factory ItemExtendedCostKey.fromEntity(ItemExtendedCostEntity entity) {
    return ItemExtendedCostKey(id: entity.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemExtendedCostKey && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
