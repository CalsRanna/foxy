// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'spell_linked_spell_entity.dart';

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SpellLinkedSpellKey &&
            spellTrigger == other.spellTrigger &&
            spellEffect == other.spellEffect &&
            type == other.type;
  }

  @override
  int get hashCode => Object.hashAll([spellTrigger, spellEffect, type]);

  @override
  String toString() {
    return 'SpellLinkedSpellKey('
        'spellTrigger: $spellTrigger, '
        'spellEffect: $spellEffect, '
        'type: $type'
        ')';
  }
}
