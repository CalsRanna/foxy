// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND
import 'spell_linked_spell_entity.key.g.dart';

final class BriefSpellLinkedSpellEntity {
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
      spellTrigger: (json['spell_trigger'] as num?)?.toInt() ?? 0,
      spellEffect: (json['spell_effect'] as num?)?.toInt() ?? 0,
      type: (json['type'] as num?)?.toInt() ?? 0,
      comment: json['comment']?.toString() ?? '',
    );
  }

  SpellLinkedSpellKey get key {
    return SpellLinkedSpellKey(
      spellTrigger: spellTrigger,
      spellEffect: spellEffect,
      type: type,
    );
  }
}
