import 'package:foxy/entity/item_display_info_entity.dart';

class ItemDisplayInfoKey {
  final int id;

  const ItemDisplayInfoKey({required this.id});

  factory ItemDisplayInfoKey.fromEntity(ItemDisplayInfoEntity entity) =>
      ItemDisplayInfoKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ItemDisplayInfoKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
