import 'support/entity_validation_test_extensions.dart';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/constant/scaling_stat_distribution_constants.dart';
import 'package:foxy/entity/scaling_stat_distribution_entity.dart';
import 'support/local_dart_library_source.dart';

void main() {
  test('Entity 精确覆盖 22 个物理列且全部为标量', () {
    final json = const ScalingStatDistributionEntity().toJson();
    expect(json.keys.toList(), [
      'ID',
      'StatID0',
      'StatID1',
      'StatID2',
      'StatID3',
      'StatID4',
      'StatID5',
      'StatID6',
      'StatID7',
      'StatID8',
      'StatID9',
      'Bonus0',
      'Bonus1',
      'Bonus2',
      'Bonus3',
      'Bonus4',
      'Bonus5',
      'Bonus6',
      'Bonus7',
      'Bonus8',
      'Bonus9',
      'Maxlevel',
    ]);
    expect(json.values.whereType<List<Object?>>(), isEmpty);
    expect(json.values.whereType<Map<Object?, Object?>>(), isEmpty);
  });

  test('属性类型使用本表的空槽和实际 ItemModType 域', () {
    expect(kScalingStatDistributionStatOptions, containsPair(-1, '空槽'));
    expect(kScalingStatDistributionStatOptions, containsPair(0, '法力值'));
    expect(
      kScalingStatDistributionStatOptions,
      containsPair(40, '野性攻击强度（客户端兼容）'),
    );
    expect(kScalingStatDistributionStatOptions, containsPair(48, '格挡值'));
    expect(kScalingStatDistributionStatOptions, isNot(contains(2)));
    expect(kScalingStatDistributionStatOptions, isNot(contains(8)));
    expect(kScalingStatDistributionStatOptions, isNot(contains(11)));
  });

  test('校验保留实际 DBC 的零值语义并拒绝无效类型和值域', () {
    expect(
      const ScalingStatDistributionEntity(
        id: 1,
        statId0: 40,
        bonus0: 0,
        maxlevel: 0,
      ).validate,
      returnsNormally,
    );
    expect(
      () => const ScalingStatDistributionEntity(id: 1, statId0: 2).validate(),
      throwsStateError,
    );
    expect(
      () => const ScalingStatDistributionEntity(id: 1, bonus0: -1).validate(),
      throwsStateError,
    );
    expect(
      () => const ScalingStatDistributionEntity(id: 32768).validate(),
      throwsStateError,
    );
  });

  test('空槽为 -1 且属性类型 0 能正常显示', () {
    const entity = ScalingStatDistributionEntity(
      id: 1,
      statId0: 0,
      bonus0: 10000,
    );
    expect(entity.displayStats, '0+10000');
    expect(const ScalingStatDistributionEntity().statId9, -1);
    expect(const ScalingStatDistributionEntity().maxlevel, 80);
  });

  test('Entity 和 ViewModel 不用数组、Map 或循环管理重复槽位', () {
    final entity = File(
      'lib/entity/scaling_stat_distribution_entity.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/scaling_stat_distribution/scaling_stat_distribution_detail_view_model.dart',
    ).readAsStringSync();
    for (final source in [entity, viewModel]) {
      expect(source, isNot(contains('final List<')));
      expect(source, isNot(contains('final Map<')));
      expect(source, isNot(contains('final stats = [')));
      expect(source, isNot(contains('final bonuses = [')));
      expect(source, isNot(contains('for (')));
    }
    expect(entity, contains('append(statId0, bonus0);'));
    expect(entity, contains('append(statId9, bonus9);'));
    expect(viewModel, contains('statId0Controller.collect()'));
    expect(viewModel, contains('statId9Controller.collect()'));
    expect(viewModel, contains('bonus0Controller.init('));
    expect(viewModel, contains('bonus9Controller.init('));
  });

  test('详情页使用专属下拉且每个表单行均为四列等宽', () {
    final view = File(
      'lib/page/scaling_stat_distribution/scaling_stat_distribution_view.dart',
    ).readAsStringSync();
    expect('FoxyIntShadSelect('.allMatches(view), hasLength(10));
    expect(
      'kScalingStatDistributionStatOptions'.allMatches(view),
      hasLength(10),
    );
    expect('Expanded(child:'.allMatches(view), hasLength(24));
    expect(view, isNot(contains('flex:')));
    expect(view, isNot(contains('有效属性数量')));
    expect(view, isNot(contains('readOnly: true')));
  });

  test('Repository 使用原始键、完整 candidate 和单表边界', () {
    final repository = readLocalDartLibrarySource(
      'lib/repository/scaling_stat_distribution_repository.dart',
    );
    final viewModel = File(
      'lib/page/scaling_stat_distribution/scaling_stat_distribution_detail_view_model.dart',
    ).readAsStringSync();
    final di = File('lib/di.dart').readAsStringSync();
    expect(
      File(
        'lib/repository/scaling_stat_distribution_solo_repository.dart',
      ).existsSync(),
      isFalse,
    );
    expect(repository, contains('int originalKey'));
    expect(repository, contains('.update(distribution.toJson())'));
    expect(repository, contains('matchedRows == 0'));
    expect(repository, contains('deletedRows == 0'));
    expect(repository, contains('MysqlErrorUtil.isDuplicateEntry(error)'));
    expect(repository, isNot(contains('.validate()')));
    expect(
      viewModel,
      contains('validateScalingStatDistributionFields(candidate);'),
    );
    expect(viewModel, contains('signal<int?>(null)'));
    expect(viewModel, contains('final originalKey = persistedKey.value'));
    expect(
      viewModel,
      contains('updateScalingStatDistribution(originalKey, candidate)'),
    );
    expect(viewModel, contains('persistedKey.value = candidate.id'));
    expect(repository, isNot(contains("table('item_template')")));
    expect(repository, isNot(contains("remove('ID')")));
    expect(
      'registerLazySingleton(() => ScalingStatDistributionRepository())'
          .allMatches(di),
      hasLength(1),
    );
  });

  test('DBC definition 与 AzerothCore 3.3.5a 的 22 列格式一致', () {
    final definition = dbcDefinitionByTable['dbc_scaling_stat_distribution']!;
    expect(definition.fileName, 'ScalingStatDistribution.dbc');
    expect(definition.schema.format, 'niiiiiiiiiiiiiiiiiiiii');
    expect(definition.schema.fields, hasLength(22));
  });
}
