import 'package:foxy/constant/spell_enums.dart';
import 'package:foxy_annotation/entity_annotations.dart';

part 'spell_linked_spell_entity.g.dart';

/// Spell linked spells

@FoxyBriefEntity()
@FoxyFullEntity()
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

extension BriefSpellLinkedSpellEntityLabel on BriefSpellLinkedSpellEntity {
  /// 链接类型标签（施放/命中/光环），未知值回退为原始数字。
  String get typeLabel =>
      SpellEnums.spellLinkedTypeOptions[type] ?? type.toString();
}
