import 'package:flutter/foundation.dart';
import 'package:foxy/entity/spell_icon_entity.dart';

@immutable
final class SpellIconKey {
  final int id;

  const SpellIconKey({required this.id});

  factory SpellIconKey.fromEntity(SpellIconEntity value) {
    return SpellIconKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is SpellIconKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
