import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/scaling_stat_distribution_constants.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';

void main() {

  test('属性类型使用本表的空槽和实际 ItemModType 域', () {
    expect(ScalingStatDistributionConstants.scalingStatDistributionStatOptions, containsPair(-1, '空槽'));
    expect(ScalingStatDistributionConstants.scalingStatDistributionStatOptions, containsPair(0, '法力值'));
    expect(
      ScalingStatDistributionConstants.scalingStatDistributionStatOptions,
      containsPair(40, '野性攻击强度（客户端兼容）'),
    );
    expect(ScalingStatDistributionConstants.scalingStatDistributionStatOptions, containsPair(48, '格挡值'));
    expect(ScalingStatDistributionConstants.scalingStatDistributionStatOptions, isNot(contains(2)));
    expect(ScalingStatDistributionConstants.scalingStatDistributionStatOptions, isNot(contains(8)));
    expect(ScalingStatDistributionConstants.scalingStatDistributionStatOptions, isNot(contains(11)));
  });

  test('空槽为 -1 且属性类型 0 能正常显示', () {
    const entity = ScalingStatDistributionEntity(
      id: 1,
      statId0: 0,
      bonus0: 10000,
    );
    expect(entity.displayStats, '法力值(10000)');
    expect(const ScalingStatDistributionEntity().statId9, -1);
    expect(const ScalingStatDistributionEntity().maxlevel, 80);
  });

  test('属性分布用属性名显示并过滤无效槽位', () {
    const entity = ScalingStatDistributionEntity(
      id: 1,
      statId0: 0,
      bonus0: 0, // 无效的 0+0 占位（旧数据把 0 当"无"）
      statId1: 3,
      bonus1: 300,
      statId3: 1,
      bonus3: 300,
    );
    expect(entity.displayStats, '敏捷(300), 生命值(300)');
  });

  test('全部槽位为空时显示 -', () {
    const entity = ScalingStatDistributionEntity(id: 1);
    expect(entity.displayStats, '-');
  });

  test('常量表外的未知属性回退为数字', () {
    const entity = ScalingStatDistributionEntity(
      id: 1,
      statId1: 2, // 旧版遗留的"法力值"编号，新版常量表无此值
      bonus1: 300,
    );
    expect(entity.displayStats, '2(300)');
  });

  test('statEntries 返回过滤后的槽位列表', () {
    const entity = ScalingStatDistributionEntity(
      id: 1,
      statId0: -1, // 空槽
      statId1: 0,
      bonus1: 0, // 0+0 占位
      statId2: 3,
      bonus2: 300,
    );
    expect(
      ScalingStatDistributionEntity.statEntries(
        [entity.statId0, entity.statId1, entity.statId2],
        [entity.bonus0, entity.bonus1, entity.bonus2],
      ),
      [(3, 300)],
    );
  });

  test('DBC definition 与 AzerothCore 3.3.5a 的 22 列格式一致', () {
    final definition = DbcDefinitions.byTable['dbc_scaling_stat_distribution']!;
    expect(definition.fileName, 'ScalingStatDistribution.dbc');
    expect(definition.schema.format, 'niiiiiiiiiiiiiiiiiiiii');
    expect(definition.schema.fields, hasLength(22));
  });
}
