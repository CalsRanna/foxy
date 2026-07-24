import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'spell_linked_spell_entity.g.dart';

/// 法术链接技能

@FoxyBriefEntity()
@FoxyFullEntity(table: 'spell_linked_spell')
class SpellLinkedSpellEntity with _SpellLinkedSpellEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('spell_trigger', key: true)
  final int spellTrigger;

  @FoxyBriefField()
  @FoxyFullField('spell_effect', key: true)
  final int spellEffect;

  @FoxyBriefField()
  @FoxyFullField('type', key: true)
  final int type;

  @FoxyBriefField()
  @FoxyFullField('comment')
  final String comment;

  const SpellLinkedSpellEntity({
    this.spellTrigger = 0,
    this.spellEffect = 0,
    this.type = 0,
    this.comment = '',
  });

  factory SpellLinkedSpellEntity.fromJson(Map<String, dynamic> json) =>
      _SpellLinkedSpellEntityMixin.fromJson(json);
}
