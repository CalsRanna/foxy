import 'package:foxy/infrastructure/codegen/entity_annotations.dart';

part 'scaling_stat_distribution_entity.g.dart';

@FoxyFilterEntity()
@FoxyFullEntity(table: 'foxy.dbc_scaling_stat_distribution')
class ScalingStatDistributionEntity with _ScalingStatDistributionEntityMixin {
  @FoxyFilterField(defaultValue: '', type: FoxyFilterFieldType.text)
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyFullField('StatID0')
  final int statId0;

  @FoxyFullField('StatID1')
  final int statId1;

  @FoxyFullField('StatID2')
  final int statId2;

  @FoxyFullField('StatID3')
  final int statId3;

  @FoxyFullField('StatID4')
  final int statId4;

  @FoxyFullField('StatID5')
  final int statId5;

  @FoxyFullField('StatID6')
  final int statId6;

  @FoxyFullField('StatID7')
  final int statId7;

  @FoxyFullField('StatID8')
  final int statId8;

  @FoxyFullField('StatID9')
  final int statId9;

  @FoxyFullField('Bonus0')
  final int bonus0;

  @FoxyFullField('Bonus1')
  final int bonus1;

  @FoxyFullField('Bonus2')
  final int bonus2;

  @FoxyFullField('Bonus3')
  final int bonus3;

  @FoxyFullField('Bonus4')
  final int bonus4;

  @FoxyFullField('Bonus5')
  final int bonus5;

  @FoxyFullField('Bonus6')
  final int bonus6;

  @FoxyFullField('Bonus7')
  final int bonus7;

  @FoxyFullField('Bonus8')
  final int bonus8;

  @FoxyFullField('Bonus9')
  final int bonus9;

  @FoxyFullField('Maxlevel')
  final int maxlevel;

  const ScalingStatDistributionEntity({
    this.id = 0,
    this.statId0 = -1,
    this.statId1 = -1,
    this.statId2 = -1,
    this.statId3 = -1,
    this.statId4 = -1,
    this.statId5 = -1,
    this.statId6 = -1,
    this.statId7 = -1,
    this.statId8 = -1,
    this.statId9 = -1,
    this.bonus0 = 0,
    this.bonus1 = 0,
    this.bonus2 = 0,
    this.bonus3 = 0,
    this.bonus4 = 0,
    this.bonus5 = 0,
    this.bonus6 = 0,
    this.bonus7 = 0,
    this.bonus8 = 0,
    this.bonus9 = 0,
    this.maxlevel = 80,
  });

  factory ScalingStatDistributionEntity.fromJson(Map<String, dynamic> json) =>
      _ScalingStatDistributionEntityMixin.fromJson(json);

  String get displayStats {
    final result = StringBuffer();
    void append(int statId, int bonus) {
      if (statId < 0) return;
      if (result.isNotEmpty) result.write(', ');
      result.write('$statId+$bonus');
    }

    append(statId0, bonus0);
    append(statId1, bonus1);
    append(statId2, bonus2);
    append(statId3, bonus3);
    append(statId4, bonus4);
    append(statId5, bonus5);
    append(statId6, bonus6);
    append(statId7, bonus7);
    append(statId8, bonus8);
    append(statId9, bonus9);
    return result.isEmpty ? '-' : result.toString();
  }
}
