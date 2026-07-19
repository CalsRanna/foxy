import 'package:flutter/foundation.dart';
import 'package:foxy/entity/item_visuals_entity.dart';

@immutable
final class ItemVisualsKey {
  final int id;

  const ItemVisualsKey({required this.id});

  factory ItemVisualsKey.fromEntity(ItemVisualsEntity value) {
    return ItemVisualsKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is ItemVisualsKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
