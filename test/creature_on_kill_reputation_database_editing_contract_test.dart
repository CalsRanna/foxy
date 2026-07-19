import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_creature_on_kill_reputation_entity.dart';
import 'package:foxy/entity/creature_on_kill_reputation_entity.dart';
import 'package:foxy/entity/creature_on_kill_reputation_key.dart';
import 'package:foxy/page/creature_template/creature_on_kill_reputation_view_model.dart';
import 'package:foxy/repository/creature_on_kill_reputation_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/validation/creature_on_kill_reputation_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Key 和 Brief 使用 creature_id 完整定位', () {
    const entity = CreatureOnKillReputationEntity(creatureID: 10);
    final key = CreatureOnKillReputationKey.fromEntity(entity);
    final same = CreatureOnKillReputationKey.fromEntity(
      entity.copyWith(maxStanding1: 4),
    );
    const brief = BriefCreatureOnKillReputationEntity(creatureID: 10);

    expect(key, same);
    expect(key.hashCode, same.hashCode);
    expect(
      key,
      isNot(
        CreatureOnKillReputationKey.fromEntity(entity.copyWith(creatureID: 11)),
      ),
    );
    expect(brief.key, key);
  });

  group('Repository write contract', () {
    test('UPDATE 使用旧 key 定位并写入 candidate 全部十列', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );
      const oldKey = CreatureOnKillReputationKey(creatureID: 10);
      const candidate = CreatureOnKillReputationEntity(
        creatureID: 11,
        rewOnKillRepFaction1: 1,
        rewOnKillRepFaction2: 2,
        maxStanding1: 3,
        maxStanding2: 4,
        isTeamAward1: true,
        isTeamAward2: false,
        rewOnKillRepValue1: 5.5,
        rewOnKillRepValue2: -2.0,
        teamDependent: 1,
      );

      await repository.updateCreatureOnKillReputation(oldKey, candidate);

      expect(queries.single.bindings, [
        ...candidate.toJson().values,
        oldKey.creatureID,
      ]);
    });

    test('UPDATE 与 DELETE 零行报告旧记录不存在', () async {
      final repository = _TestRepository(
        Laconic(_RecordingDriver(affectedRows: 0)),
      );
      const key = CreatureOnKillReputationKey(creatureID: 10);
      await expectLater(
        repository.updateCreatureOnKillReputation(
          key,
          const CreatureOnKillReputationEntity(),
        ),
        throwsA(isA<StateError>()),
      );
      await expectLater(
        repository.destroyCreatureOnKillReputation(key),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('one-row child persisted identity', () {
    late _FakeRepository repository;

    setUp(() {
      repository = _FakeRepository([
        const CreatureOnKillReputationEntity(creatureID: 10),
      ]);
      GetIt.instance.registerSingleton<CreatureOnKillReputationRepository>(
        repository,
      );
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());
    });

    tearDown(() async => GetIt.instance.reset());

    test('key 修改失败保留旧 key，成功后按当前父范围重新判定身份', () async {
      final viewModel = CreatureOnKillReputationViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(creatureId: 10);
      const oldKey = CreatureOnKillReputationKey(creatureID: 10);
      expect(viewModel.editingKey.value, oldKey);
      viewModel.creatureIdController.init(11);
      repository.failUpdates = true;

      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, oldKey);

      repository.failUpdates = false;
      await viewModel.persist();
      expect(repository.updateKeys, [oldKey, oldKey]);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.creatureIdController.collect(), 10);

      await viewModel.setParentCreatureID(11);
      expect(
        viewModel.editingKey.value,
        const CreatureOnKillReputationKey(creatureID: 11),
      );
    });

    test('没有当前父行时执行 create，成功后切换为 persisted key', () async {
      final viewModel = CreatureOnKillReputationViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(creatureId: 12);
      expect(viewModel.editingKey.value, isNull);

      await viewModel.persist();

      expect(repository.storeCount, 1);
      expect(
        viewModel.editingKey.value,
        const CreatureOnKillReputationKey(creatureID: 12),
      );
    });
  });

  test('validation、UI 和 Repository 边界正确', () {
    final validation = _Validation();
    expect(
      () => validation.validateCreatureOnKillReputationFields(
        const CreatureOnKillReputationEntity(creatureID: 1, teamDependent: 2),
      ),
      throwsA(isA<StateError>()),
    );
    final repository = File(
      'lib/repository/creature_on_kill_reputation_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/creature_template/creature_on_kill_reputation_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/creature_template/creature_on_kill_reputation_view.dart',
    ).readAsStringSync();

    expect(repository, isNot(contains('saveCreatureOnKillReputation')));
    expect(
      viewModel,
      contains('final editingKey = signal<CreatureOnKillReputationKey?>(null)'),
    );
    expect(viewModel, isNot(contains('final reputation = signal')));
    expect(view, isNot(contains('readOnly: true')));
    expect(view, isNot(contains('initControllers(repData)')));
  });
}

class _FakeRepository extends CreatureOnKillReputationRepository {
  final List<CreatureOnKillReputationEntity> rows;
  bool failUpdates = false;
  int storeCount = 0;
  final updateKeys = <CreatureOnKillReputationKey>[];

  _FakeRepository(this.rows);

  @override
  Future<CreatureOnKillReputationEntity?> getCreatureOnKillReputation(
    CreatureOnKillReputationKey key,
  ) async {
    for (final row in rows) {
      if (CreatureOnKillReputationKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> storeCreatureOnKillReputation(
    CreatureOnKillReputationEntity rep,
  ) async {
    storeCount++;
    rows.add(rep);
  }

  @override
  Future<void> updateCreatureOnKillReputation(
    CreatureOnKillReputationKey originalKey,
    CreatureOnKillReputationEntity rep,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => CreatureOnKillReputationKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = rep;
  }
}

class _Validation
    with ViewModelValidationMixin, CreatureOnKillReputationValidationMixin {}

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

class _TestRepository extends CreatureOnKillReputationRepository {
  @override
  final Laconic laconic;
  _TestRepository(this.laconic);
}
