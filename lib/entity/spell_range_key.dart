import 'package:flutter/foundation.dart';
import 'package:foxy/entity/spell_range_entity.dart';

@immutable
final class SpellRangeKey {
  final int id;

  const SpellRangeKey({required this.id});

  factory SpellRangeKey.fromEntity(SpellRangeEntity value) {
    return SpellRangeKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is SpellRangeKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
