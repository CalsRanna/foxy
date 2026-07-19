import 'package:foxy/entity/spell_linked_spell_key.dart';

class BriefSpellLinkedSpellEntity {
  final int spellTrigger;
  final int spellEffect;
  final int type;
  final String comment;

  const BriefSpellLinkedSpellEntity({
    this.spellTrigger = 0,
    this.spellEffect = 0,
    this.type = 0,
    this.comment = '',
  });

  factory BriefSpellLinkedSpellEntity.fromJson(Map<String, dynamic> json) {
    return BriefSpellLinkedSpellEntity(
      spellTrigger: json['spell_trigger'] ?? 0,
      spellEffect: json['spell_effect'] ?? 0,
      type: json['type'] ?? 0,
      comment: json['comment']?.toString() ?? '',
    );
  }

  SpellLinkedSpellKey get key => SpellLinkedSpellKey(
    spellTrigger: spellTrigger,
    spellEffect: spellEffect,
    type: type,
  );
}
