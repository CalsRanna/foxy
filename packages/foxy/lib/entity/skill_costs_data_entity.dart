import 'package:foxy_annotation/entity_annotations.dart';

part 'skill_costs_data_entity.g.dart';

/// SkillCostsData — skill cost columns referenced by SkillLine.SkillCostsID
@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_skill_costs_data')
class SkillCostsDataEntity with _SkillCostsDataEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('SkillCostsID')
  final int skillCostsId;

  @FoxyFullField('Cost0')
  final int cost0;

  @FoxyFullField('Cost1')
  final int cost1;

  @FoxyFullField('Cost2')
  final int cost2;

  const SkillCostsDataEntity({
    this.id = 0,
    this.skillCostsId = 0,
    this.cost0 = 0,
    this.cost1 = 0,
    this.cost2 = 0,
  });

  factory SkillCostsDataEntity.fromJson(Map<String, dynamic> json) =>
      _SkillCostsDataEntityMixin.fromJson(json);
}
