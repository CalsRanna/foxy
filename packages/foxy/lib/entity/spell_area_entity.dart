import 'package:foxy_annotation/entity_annotations.dart';
import 'package:foxy_annotation/semantic_annotations.dart';
import 'package:foxy_game_definition/foxy_game_definition.dart';

part 'spell_area_entity.g.dart';

/// Spell-area spells

@FoxyBriefEntity()
@FoxyBriefField.text('auraSpellName')
@FoxyBriefField.text('auraSpellTextureFilename')
@FoxyFullEntity()
class SpellAreaEntity with _SpellAreaEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('spell', key: true)
  final int spell;

  @FoxyBriefField()
  @FoxyFullField('area', key: true)
  final int area;

  @FoxyBriefField()
  @FoxyFullField('quest_start', key: true)
  final int questStart;

  @FoxyBriefField()
  @FoxyFullField('quest_end')
  final int questEnd;

  @FoxyBriefField()
  @FoxyFullField('aura_spell', key: true)
  final int auraSpell;

  @FoxyBriefField()
  @FoxyFieldMeaning.flags('种族掩码', flags: ItemFlags.allowableRaceOptions)
  @FoxyFullField('racemask', key: true)
  final int racemask;

  @FoxyBriefField()
  @FoxyFieldMeaning.enumValues('性别', values: SpellEnums.spellAreaGenderOptions)
  @FoxyFullField('gender', key: true)
  final int gender;

  @FoxyFieldMeaning.enumValues('自动施放', values: CreatureEnums.booleanOptions)
  @FoxyFullField('autocast')
  final int autocast;

  @FoxyBriefField()
  @FoxyFieldMeaning.flags(
    '任务开始状态',
    flags: SpellFlags.spellAreaQuestStatusOptions,
  )
  @FoxyFullField('quest_start_status')
  final int questStartStatus;

  @FoxyBriefField()
  @FoxyFieldMeaning.flags(
    '任务结束状态',
    flags: SpellFlags.spellAreaQuestStatusOptions,
  )
  @FoxyFullField('quest_end_status')
  final int questEndStatus;

  const SpellAreaEntity({
    this.spell = 0,
    this.area = 0,
    this.questStart = 0,
    this.questEnd = 0,
    this.auraSpell = 0,
    this.racemask = 0,
    this.gender = 2,
    this.autocast = 0,
    this.questStartStatus = 64,
    this.questEndStatus = 11,
  });

  factory SpellAreaEntity.fromJson(Map<String, dynamic> json) =>
      _SpellAreaEntityMixin.fromJson(json);
}

extension BriefSpellAreaEntityLabel on BriefSpellAreaEntity {
  /// Matching quest end status labels, with the raw mask as a fallback.
  String get questEndStatusLabel => FlagItem.maskLabel(
    questEndStatus,
    SpellFlags.spellAreaQuestStatusOptions,
  );

  /// Matching quest start status labels, with the raw mask as a fallback.
  String get questStartStatusLabel => FlagItem.maskLabel(
    questStartStatus,
    SpellFlags.spellAreaQuestStatusOptions,
  );
}
