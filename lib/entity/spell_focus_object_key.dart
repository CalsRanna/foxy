import 'package:flutter/foundation.dart';
import 'package:foxy/entity/spell_focus_object_entity.dart';

@immutable
final class SpellFocusObjectKey {
  final int id;

  const SpellFocusObjectKey({required this.id});

  factory SpellFocusObjectKey.fromEntity(SpellFocusObjectEntity value) {
    return SpellFocusObjectKey(id: value.id);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellFocusObjectKey && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
