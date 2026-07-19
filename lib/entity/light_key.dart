import 'package:flutter/foundation.dart';
import 'package:foxy/entity/light_entity.dart';

@immutable
final class LightKey {
  final int id;

  const LightKey({required this.id});

  factory LightKey.fromEntity(LightEntity value) {
    return LightKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is LightKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
