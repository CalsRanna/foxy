import 'package:foxy/entity/item_random_properties_entity.dart';

class ItemRandomPropertiesKey {
  final int id;

  const ItemRandomPropertiesKey({required this.id});

  factory ItemRandomPropertiesKey.fromEntity(
    ItemRandomPropertiesEntity entity,
  ) => ItemRandomPropertiesKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemRandomPropertiesKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
