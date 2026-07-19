import 'package:flutter/foundation.dart';
import 'package:foxy/entity/liquid_type_entity.dart';

@immutable
final class LiquidTypeKey {
  final int id;

  const LiquidTypeKey({required this.id});

  factory LiquidTypeKey.fromEntity(LiquidTypeEntity value) {
    return LiquidTypeKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is LiquidTypeKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
