import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

part 'spell_linked_spell_entity.g.dart';

/// Spell linked spells

@FoxyBriefEntity()
@FoxyBriefField.text('effectSpellName')
@FoxyBriefField.text('effectSpellTextureFilename')
@FoxyFullEntity()
class SpellLinkedSpellEntity with _SpellLinkedSpellEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('spell_trigger', key: true)
  final int spellTrigger;

  @FoxyBriefField()
  @FoxyFullField('spell_effect', key: true)
  final int spellEffect;

  @FoxyBriefField()
  @FoxyFieldMeaning.enumValues(
    '关联类型',
    values: SpellEnums.spellLinkedTypeOptions,
  )
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

extension BriefSpellLinkedSpellEntityLabel on BriefSpellLinkedSpellEntity {
  /// 链接类型标签（施放/命中/光环），未知值回退为原始数字。
  String get typeLabel =>
      SpellEnums.spellLinkedTypeOptions[type] ?? type.toString();
}
