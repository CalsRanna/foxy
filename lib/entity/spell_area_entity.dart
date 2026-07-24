import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'spell_area_entity.g.dart';

/// 法术区域技能

@FoxyBriefEntity()
@FoxyFullEntity(table: 'spell_area')
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
  @FoxyFullField('racemask', key: true)
  final int racemask;

  @FoxyBriefField()
  @FoxyFullField('gender', key: true)
  final int gender;

  @FoxyFullField('autocast')
  final int autocast;

  @FoxyBriefField()
  @FoxyFullField('quest_start_status')
  final int questStartStatus;

  @FoxyBriefField()
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
