// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'spell_group_entity.dart';

final class SpellGroupKey {
  final int id;
  final int spellId;

  const SpellGroupKey({required this.id, required this.spellId});

  factory SpellGroupKey.fromEntity(SpellGroupEntity entity) {
    return SpellGroupKey(id: entity.id, spellId: entity.spellId);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellGroupKey && id == other.id && spellId == other.spellId;
  }

  @override
  int get hashCode => Object.hashAll([id, spellId]);

  @override
  String toString() {
    return 'SpellGroupKey('
        'id: $id, '
        'spellId: $spellId'
        ')';
  }
}
