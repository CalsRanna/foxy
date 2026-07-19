import 'package:foxy/entity/item_random_suffix_entity.dart';

class ItemRandomSuffixKey {
  final int id;

  const ItemRandomSuffixKey({required this.id});

  factory ItemRandomSuffixKey.fromEntity(ItemRandomSuffixEntity entity) =>
      ItemRandomSuffixKey(id: entity.id);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ItemRandomSuffixKey && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
