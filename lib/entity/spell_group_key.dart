import 'package:foxy/entity/spell_group_entity.dart';

final class SpellGroupKey {
  final int id;
  final int spellId;

  const SpellGroupKey({required this.id, required this.spellId});

  factory SpellGroupKey.fromEntity(SpellGroupEntity entity) {
    return SpellGroupKey(id: entity.id, spellId: entity.spellId);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellGroupKey && other.id == id && other.spellId == spellId;

  @override
  int get hashCode => Object.hash(id, spellId);
}
