import 'package:flutter/foundation.dart';
import 'package:foxy/entity/totem_category_entity.dart';

@immutable
final class TotemCategoryKey {
  final int id;

  const TotemCategoryKey({required this.id});

  factory TotemCategoryKey.fromEntity(TotemCategoryEntity value) {
    return TotemCategoryKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is TotemCategoryKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
