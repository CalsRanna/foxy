import 'package:foxy/entity/item_purchase_group_entity.dart';

class ItemPurchaseGroupKey {
  final int id;

  const ItemPurchaseGroupKey({required this.id});

  factory ItemPurchaseGroupKey.fromEntity(ItemPurchaseGroupEntity entity) =>
      ItemPurchaseGroupKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ItemPurchaseGroupKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
