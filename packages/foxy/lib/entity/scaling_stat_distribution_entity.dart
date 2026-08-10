import 'package:foxy/constant/scaling_stat_distribution_constants.dart';
import 'package:foxy_annotation/entity_annotations.dart';

part 'scaling_stat_distribution_entity.g.dart';

@FoxyBriefEntity()
@FoxyFullEntity(table: 'foxy.dbc_scaling_stat_distribution')
class ScalingStatDistributionEntity with _ScalingStatDistributionEntityMixin {
  /// 有效属性槽位列表，entity 与 brief entity 共用。
  ///
  /// - `-1` 空槽不显示；
  /// - `0+0` 这类无效占位（旧数据把 0 当"无"）不显示。
  static List<(int, int)> statEntries(List<int> statIds, List<int> bonuses) {
    final entries = <(int, int)>[];
    for (var i = 0; i < statIds.length; i++) {
      final statId = statIds[i];
      if (statId < 0) continue; // 空槽
      if (statId == 0 && bonuses[i] == 0) continue; // 无效的 0+0 占位
      entries.add((statId, bonuses[i]));
    }
    return entries;
  }

  /// 汇总一组属性槽位为展示文本，如 `敏捷(300), 生命值(300)`。
  ///
  /// 常量表外的未知属性回退为数字，保证信息不丢失。
  static String formatStats(List<int> statIds, List<int> bonuses) {
    final result = StringBuffer();
    for (final (statId, bonus) in statEntries(statIds, bonuses)) {
      final name = ScalingStatDistributionConstants
          .scalingStatDistributionStatOptions[statId];
      if (result.isNotEmpty) result.write(', ');
      result.write('${name ?? '$statId'}($bonus)');
    }
    return result.isEmpty ? '-' : result.toString();
  }

  @FoxyBriefField()
  @FoxyFullField('ID', key: true)
  final int id;

  @FoxyBriefField()
  @FoxyFullField('StatID0')
  final int statId0;

  @FoxyBriefField()
  @FoxyFullField('StatID1')
  final int statId1;

  @FoxyBriefField()
  @FoxyFullField('StatID2')
  final int statId2;

  @FoxyBriefField()
  @FoxyFullField('StatID3')
  final int statId3;

  @FoxyBriefField()
  @FoxyFullField('StatID4')
  final int statId4;

  @FoxyBriefField()
  @FoxyFullField('StatID5')
  final int statId5;

  @FoxyBriefField()
  @FoxyFullField('StatID6')
  final int statId6;

  @FoxyBriefField()
  @FoxyFullField('StatID7')
  final int statId7;

  @FoxyBriefField()
  @FoxyFullField('StatID8')
  final int statId8;

  @FoxyBriefField()
  @FoxyFullField('StatID9')
  final int statId9;

  @FoxyBriefField()
  @FoxyFullField('Bonus0')
  final int bonus0;

  @FoxyBriefField()
  @FoxyFullField('Bonus1')
  final int bonus1;

  @FoxyBriefField()
  @FoxyFullField('Bonus2')
  final int bonus2;

  @FoxyBriefField()
  @FoxyFullField('Bonus3')
  final int bonus3;

  @FoxyBriefField()
  @FoxyFullField('Bonus4')
  final int bonus4;

  @FoxyBriefField()
  @FoxyFullField('Bonus5')
  final int bonus5;

  @FoxyBriefField()
  @FoxyFullField('Bonus6')
  final int bonus6;

  @FoxyBriefField()
  @FoxyFullField('Bonus7')
  final int bonus7;

  @FoxyBriefField()
  @FoxyFullField('Bonus8')
  final int bonus8;

  @FoxyBriefField()
  @FoxyFullField('Bonus9')
  final int bonus9;

  @FoxyBriefField()
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

  /// 属性分布展示文本，如 `敏捷(300), 生命值(300)`。
  ///
  /// - `-1` 空槽不显示；
  /// - `0+0` 这类无效占位（旧数据把 0 当"无"）不显示；
  /// - 常量表外的未知属性回退为数字，保证信息不丢失。
  String get displayStats => ScalingStatDistributionEntity.formatStats(
    [
      statId0,
      statId1,
      statId2,
      statId3,
      statId4,
      statId5,
      statId6,
      statId7,
      statId8,
      statId9,
    ],
    [
      bonus0,
      bonus1,
      bonus2,
      bonus3,
      bonus4,
      bonus5,
      bonus6,
      bonus7,
      bonus8,
      bonus9,
    ],
  );
}

extension BriefScalingStatDistributionEntityDisplay
    on BriefScalingStatDistributionEntity {
  /// 属性分布展示文本，如 `敏捷(300), 生命值(300)`。
  ///
  /// - `-1` 空槽不显示；
  /// - `0+0` 这类无效占位（旧数据把 0 当"无"）不显示；
  /// - 常量表外的未知属性回退为数字，保证信息不丢失。
  String get displayStats => ScalingStatDistributionEntity.formatStats(
    [
      statId0,
      statId1,
      statId2,
      statId3,
      statId4,
      statId5,
      statId6,
      statId7,
      statId8,
      statId9,
    ],
    [
      bonus0,
      bonus1,
      bonus2,
      bonus3,
      bonus4,
      bonus5,
      bonus6,
      bonus7,
      bonus8,
      bonus9,
    ],
  );
}
