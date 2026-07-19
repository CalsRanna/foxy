import 'package:flutter/foundation.dart';
import 'package:foxy/entity/spell_duration_entity.dart';

@immutable
final class SpellDurationKey {
  final int id;

  const SpellDurationKey({required this.id});

  factory SpellDurationKey.fromEntity(SpellDurationEntity value) {
    return SpellDurationKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellDurationKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
