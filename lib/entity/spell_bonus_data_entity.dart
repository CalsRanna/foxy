import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'spell_bonus_data_entity.g.dart';

/// 法术奖励系数

@FoxyBriefEntity()
@FoxyFullEntity(table: 'spell_bonus_data')
class SpellBonusDataEntity with _SpellBonusDataEntityMixin {
  @FoxyBriefField()
  @FoxyFullField('entry', key: true)
  final int entry;

  @FoxyBriefField()
  @FoxyFullField('direct_bonus')
  final double directBonus;

  @FoxyBriefField()
  @FoxyFullField('dot_bonus')
  final double dotBonus;

  @FoxyBriefField()
  @FoxyFullField('ap_bonus')
  final double apBonus;

  @FoxyBriefField()
  @FoxyFullField('ap_dot_bonus')
  final double apDotBonus;

  @FoxyBriefField()
  @FoxyFullField('comments')
  final String comments;

  const SpellBonusDataEntity({
    this.entry = 0,
    this.directBonus = 0.0,
    this.dotBonus = 0.0,
    this.apBonus = 0.0,
    this.apDotBonus = 0.0,
    this.comments = '',
  });

  factory SpellBonusDataEntity.fromJson(Map<String, dynamic> json) =>
      _SpellBonusDataEntityMixin.fromJson(json);
}
