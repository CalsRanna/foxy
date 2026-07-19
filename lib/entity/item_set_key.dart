import 'package:foxy/entity/item_set_entity.dart';

class ItemSetKey {
  final int id;

  const ItemSetKey({required this.id});

  factory ItemSetKey.fromEntity(ItemSetEntity entity) =>
      ItemSetKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ItemSetKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
