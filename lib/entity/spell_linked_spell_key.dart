import 'package:foxy/entity/spell_linked_spell_entity.dart';

final class SpellLinkedSpellKey {
  final int spellTrigger;
  final int spellEffect;
  final int type;

  const SpellLinkedSpellKey({
    required this.spellTrigger,
    required this.spellEffect,
    required this.type,
  });

  factory SpellLinkedSpellKey.fromEntity(SpellLinkedSpellEntity entity) {
    return SpellLinkedSpellKey(
      spellTrigger: entity.spellTrigger,
      spellEffect: entity.spellEffect,
      type: entity.type,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpellLinkedSpellKey &&
          other.spellTrigger == spellTrigger &&
          other.spellEffect == spellEffect &&
          other.type == type;

  @override
  int get hashCode => Object.hash(spellTrigger, spellEffect, type);
}
