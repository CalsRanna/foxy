import 'package:foxy_annotation/entity_annotations.dart';

part 'skill_tiers_entity.g.dart';

/// SkillTiers — per-rank skill cost/value tables referenced by
/// SkillRaceClassInfo.SkillTierID
@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_skill_tiers')
class SkillTiersEntity with _SkillTiersEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('Cost0')
  final int cost0;

  @FoxyFullField('Cost1')
  final int cost1;

  @FoxyFullField('Cost2')
  final int cost2;

  @FoxyFullField('Cost3')
  final int cost3;

  @FoxyFullField('Cost4')
  final int cost4;

  @FoxyFullField('Cost5')
  final int cost5;

  @FoxyFullField('Cost6')
  final int cost6;

  @FoxyFullField('Cost7')
  final int cost7;

  @FoxyFullField('Cost8')
  final int cost8;

  @FoxyFullField('Cost9')
  final int cost9;

  @FoxyFullField('Cost10')
  final int cost10;

  @FoxyFullField('Cost11')
  final int cost11;

  @FoxyFullField('Cost12')
  final int cost12;

  @FoxyFullField('Cost13')
  final int cost13;

  @FoxyFullField('Cost14')
  final int cost14;

  @FoxyFullField('Cost15')
  final int cost15;

  @FoxyFullField('Value0')
  final int value0;

  @FoxyFullField('Value1')
  final int value1;

  @FoxyFullField('Value2')
  final int value2;

  @FoxyFullField('Value3')
  final int value3;

  @FoxyFullField('Value4')
  final int value4;

  @FoxyFullField('Value5')
  final int value5;

  @FoxyFullField('Value6')
  final int value6;

  @FoxyFullField('Value7')
  final int value7;

  @FoxyFullField('Value8')
  final int value8;

  @FoxyFullField('Value9')
  final int value9;

  @FoxyFullField('Value10')
  final int value10;

  @FoxyFullField('Value11')
  final int value11;

  @FoxyFullField('Value12')
  final int value12;

  @FoxyFullField('Value13')
  final int value13;

  @FoxyFullField('Value14')
  final int value14;

  @FoxyFullField('Value15')
  final int value15;

  const SkillTiersEntity({
    this.id = 0,
    this.cost0 = 0,
    this.cost1 = 0,
    this.cost2 = 0,
    this.cost3 = 0,
    this.cost4 = 0,
    this.cost5 = 0,
    this.cost6 = 0,
    this.cost7 = 0,
    this.cost8 = 0,
    this.cost9 = 0,
    this.cost10 = 0,
    this.cost11 = 0,
    this.cost12 = 0,
    this.cost13 = 0,
    this.cost14 = 0,
    this.cost15 = 0,
    this.value0 = 0,
    this.value1 = 0,
    this.value2 = 0,
    this.value3 = 0,
    this.value4 = 0,
    this.value5 = 0,
    this.value6 = 0,
    this.value7 = 0,
    this.value8 = 0,
    this.value9 = 0,
    this.value10 = 0,
    this.value11 = 0,
    this.value12 = 0,
    this.value13 = 0,
    this.value14 = 0,
    this.value15 = 0,
  });

  factory SkillTiersEntity.fromJson(Map<String, dynamic> json) =>
      _SkillTiersEntityMixin.fromJson(json);
}
