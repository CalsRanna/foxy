import 'package:flutter/foundation.dart';
import 'package:foxy/entity/item_visual_effect_entity.dart';

@immutable
final class ItemVisualEffectKey {
  final int id;

  const ItemVisualEffectKey({required this.id});

  factory ItemVisualEffectKey.fromEntity(ItemVisualEffectEntity value) {
    return ItemVisualEffectKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemVisualEffectKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
