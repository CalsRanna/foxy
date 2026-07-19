import 'package:flutter/foundation.dart';
import 'package:foxy/entity/item_limit_category_entity.dart';

@immutable
final class ItemLimitCategoryKey {
  final int id;

  const ItemLimitCategoryKey({required this.id});

  factory ItemLimitCategoryKey.fromEntity(ItemLimitCategoryEntity value) {
    return ItemLimitCategoryKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ItemLimitCategoryKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
