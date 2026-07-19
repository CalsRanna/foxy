import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_creature_template_resistance_entity.dart';
import 'package:foxy/entity/creature_template_resistance_entity.dart';
import 'package:foxy/entity/creature_template_resistance_key.dart';
import 'package:foxy/page/creature_template/creature_template_resistance_view_model.dart';
import 'package:foxy/repository/creature_template_resistance_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/validation/creature_template_resistance_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CreatureTemplateResistance key 与 Brief Entity', () {
    test('两列 key 实现完整值相等', () {
      const entity = CreatureTemplateResistanceEntity(
        creatureID: 10,
        school: 2,
      );
      final key = CreatureTemplateResistanceKey.fromEntity(entity);
      final same = CreatureTemplateResistanceKey.fromEntity(
        entity.copyWith(resistance: 20),
      );

      expect(key, same);
      expect(key.hashCode, same.hashCode);
      expect(
        key,
        isNot(
          CreatureTemplateResistanceKey.fromEntity(
            entity.copyWith(creatureID: 11),
          ),
        ),
      );
      expect(
        key,
        isNot(
          CreatureTemplateResistanceKey.fromEntity(entity.copyWith(school: 3)),
        ),
      );
    });

    test('Brief Entity 提供完整 typed key', () {
      const brief = BriefCreatureTemplateResistanceEntity(
        creatureID: 10,
        school: 2,
      );
      expect(
        brief.key,
        const CreatureTemplateResistanceKey(creatureID: 10, school: 2),
      );
    });
  });

  group('CreatureTemplateResistanceRepository write contract', () {
    test('UPDATE 使用完整旧 key 定位并写入 candidate 全部四列', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestCreatureTemplateResistanceRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );
      const originalKey = CreatureTemplateResistanceKey(
        creatureID: 10,
        school: 2,
      );
      const candidate = CreatureTemplateResistanceEntity(
        creatureID: 11,
        school: 3,
        resistance: 50,
        verifiedBuild: 12340,
      );

      await repository.updateCreatureTemplateResistance(originalKey, candidate);

      expect(queries, hasLength(1));
      expect(queries.single.bindings, [
        ...candidate.toJson().values,
        originalKey.creatureID,
        originalKey.school,
      ]);
    });

    test('UPDATE 与 DELETE 零行结果报告旧记录不存在', () async {
      final repository = _TestCreatureTemplateResistanceRepository(
        Laconic(_RecordingDriver(affectedRows: 0)),
      );
      const key = CreatureTemplateResistanceKey(creatureID: 10, school: 2);

      await expectLater(
        repository.updateCreatureTemplateResistance(
          key,
          const CreatureTemplateResistanceEntity(),
        ),
        throwsA(isA<StateError>()),
      );
      await expectLater(
        repository.destroyCreatureTemplateResistance(key),
        throwsA(isA<StateError>()),
      );
    });

    test('Brief 查询显式选择字段、稳定排序并分页', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestCreatureTemplateResistanceRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );

      await repository.getBriefCreatureTemplateResistances(10, page: 2);

      expect(queries.single.sql, isNot(contains('*')));
      expect(queries.single.sql.toLowerCase(), contains('order by'));
      expect(queries.single.bindings, [10, 50, 50]);
    });
  });

  group('CreatureTemplateResistance inline identity', () {
    late _FakeCreatureTemplateResistanceRepository repository;

    setUp(() {
      repository = _FakeCreatureTemplateResistanceRepository([
        const CreatureTemplateResistanceEntity(
          creatureID: 10,
          school: 2,
          resistance: 20,
        ),
      ]);
      GetIt.instance.registerSingleton<CreatureTemplateResistanceRepository>(
        repository,
      );
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });

    test('编辑 Brief 后按旧 key 更新，candidate 可移出父范围', () async {
      final viewModel = CreatureTemplateResistanceViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(creatureId: 10);
      viewModel.selectRow(0);
      expect(await viewModel.edit(), isTrue);
      const originalKey = CreatureTemplateResistanceKey(
        creatureID: 10,
        school: 2,
      );
      expect(viewModel.editingKey.value, originalKey);

      viewModel.creatureIdController.init(11);
      viewModel.schoolController.init(3);
      await viewModel.persist();

      expect(repository.updateKeys, [originalKey]);
      expect(repository.rows.single.creatureID, 11);
      expect(repository.rows.single.school, 3);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.selectedIndex.value, isNull);
    });

    test('保存失败保留旧 editingKey，重试仍使用同一旧 key', () async {
      final viewModel = CreatureTemplateResistanceViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(creatureId: 10);
      viewModel.selectRow(0);
      await viewModel.edit();
      final originalKey = viewModel.editingKey.value;
      repository.failUpdates = true;
      viewModel.schoolController.init(3);

      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, originalKey);

      repository.failUpdates = false;
      await viewModel.persist();
      expect(repository.updateKeys, [originalKey, originalKey]);
    });

    test('切换父范围和新建会清空 editingKey', () async {
      final viewModel = CreatureTemplateResistanceViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(creatureId: 10);
      viewModel.selectRow(0);
      await viewModel.edit();

      await viewModel.setParentCreatureId(12);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.creatureIdController.collect(), 12);

      expect(await viewModel.create(), isTrue);
      expect(viewModel.editingKey.value, isNull);
      await viewModel.persist();
      expect(repository.storeCount, 1);
    });
  });

  test('字段校验、UI 和 Repository 遵守迁移合同', () {
    final validation = _CreatureTemplateResistanceValidation();
    expect(
      () => validation.validateCreatureTemplateResistanceFields(
        const CreatureTemplateResistanceEntity(creatureID: 1, school: 0),
      ),
      throwsA(isA<StateError>()),
    );
    final repository = File(
      'lib/repository/creature_template_resistance_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/creature_template/creature_template_resistance_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/creature_template/creature_template_resistance_view.dart',
    ).readAsStringSync();

    expect(repository, isNot(contains('saveCreatureTemplateResistance')));
    expect(repository, isNot(contains("json.remove('CreatureID')")));
    expect(
      viewModel,
      contains(
        'final editingKey = signal<CreatureTemplateResistanceKey?>(null)',
      ),
    );
    expect(
      viewModel,
      contains('destroyCreatureTemplateResistance(selected.key)'),
    );
    expect(view, isNot(contains('readOnly: true')));
    expect(view, isNot(contains('enabled: !isEditing')));
    expect(view, contains('FoxyPagination('));
  });
}

class _FakeCreatureTemplateResistanceRepository
    extends CreatureTemplateResistanceRepository {
  final List<CreatureTemplateResistanceEntity> rows;
  bool failUpdates = false;
  int storeCount = 0;
  final updateKeys = <CreatureTemplateResistanceKey>[];

  _FakeCreatureTemplateResistanceRepository(this.rows);

  @override
  Future<int> countCreatureTemplateResistances(int creatureID) async {
    return rows.where((row) => row.creatureID == creatureID).length;
  }

  @override
  Future<CreatureTemplateResistanceEntity> createCreatureTemplateResistance(
    int creatureID,
  ) async {
    final schools = rows
        .where((row) => row.creatureID == creatureID)
        .map((row) => row.school);
    return CreatureTemplateResistanceEntity(
      creatureID: creatureID,
      school: CreatureTemplateResistanceRepository.nextAvailableSchool(schools),
    );
  }

  @override
  Future<List<BriefCreatureTemplateResistanceEntity>>
  getBriefCreatureTemplateResistances(int creatureID, {int page = 1}) async {
    return rows
        .where((row) => row.creatureID == creatureID)
        .map(
          (row) => BriefCreatureTemplateResistanceEntity(
            creatureID: row.creatureID,
            school: row.school,
            resistance: row.resistance,
            verifiedBuild: row.verifiedBuild,
          ),
        )
        .toList();
  }

  @override
  Future<CreatureTemplateResistanceEntity?> getCreatureTemplateResistance(
    CreatureTemplateResistanceKey key,
  ) async {
    for (final row in rows) {
      if (CreatureTemplateResistanceKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> storeCreatureTemplateResistance(
    CreatureTemplateResistanceEntity resistance,
  ) async {
    storeCount++;
    rows.add(resistance);
  }

  @override
  Future<void> updateCreatureTemplateResistance(
    CreatureTemplateResistanceKey originalKey,
    CreatureTemplateResistanceEntity resistance,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => CreatureTemplateResistanceKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = resistance;
  }
}

class _CreatureTemplateResistanceValidation
    with ViewModelValidationMixin, CreatureTemplateResistanceValidationMixin {}

class _RecordingDriver implements DatabaseDriver {
  @override
  final SqlGrammar grammar = MysqlGrammar();

  final int affectedRows;

  _RecordingDriver({this.affectedRows = 1});

  @override
  Future<int> affectingStatement(
    String sql, [
    List<Object?> params = const [],
  ]) async => affectedRows;

  @override
  Future<void> close() async {}

  @override
  Future<int> insertAndGetId(
    String sql, [
    List<Object?> params = const [],
  ]) async => 1;

  @override
  Future<List<LaconicResult>> select(
    String sql, [
    List<Object?> params = const [],
  ]) async => const [];

  @override
  Future<void> statement(String sql, [List<Object?> params = const []]) async {}

  @override
  Future<T> transaction<T>(Future<T> Function() action) => action();
}

class _TestCreatureTemplateResistanceRepository
    extends CreatureTemplateResistanceRepository {
  @override
  final Laconic laconic;

  _TestCreatureTemplateResistanceRepository(this.laconic);
}
