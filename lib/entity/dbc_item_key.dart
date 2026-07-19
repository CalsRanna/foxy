import 'package:flutter/foundation.dart';
import 'package:foxy/entity/dbc_item_entity.dart';

@immutable
final class DbcItemKey {
  final int id;

  const DbcItemKey({required this.id});

  factory DbcItemKey.fromEntity(DbcItemEntity value) {
    return DbcItemKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is DbcItemKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
