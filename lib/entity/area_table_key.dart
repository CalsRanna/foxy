import 'package:flutter/foundation.dart';
import 'package:foxy/entity/area_table_entity.dart';

@immutable
final class AreaTableKey {
  final int id;

  const AreaTableKey({required this.id});

  factory AreaTableKey.fromEntity(AreaTableEntity value) {
    return AreaTableKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is AreaTableKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
