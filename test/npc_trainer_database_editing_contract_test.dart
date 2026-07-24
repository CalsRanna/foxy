import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_npc_trainer_entity.dart';
import 'package:foxy/entity/creature_default_trainer_entity.dart';
import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/page/creature_template/npc_trainer_collection_editor_view_model.dart';
import 'package:foxy/repository/creature_default_trainer_repository.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/widget/form/validation/npc_trainer_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('trainer row locators and Brief entity', () {
    test('NpcTrainerKey 覆盖 TrainerId 和 SpellId 并实现值相等', () {
      const entity = NpcTrainerEntity(trainerId: 10, spellId: 20);
      final key = NpcTrainerKey.fromEntity(entity);
      final same = NpcTrainerKey.fromEntity(entity.copyWith(moneyCost: 30));
      const brief = BriefNpcTrainerEntity(trainerId: 10, spellId: 20);

      expect(key, same);
      expect(key.hashCode, same.hashCode);
      expect(
        key,
        isNot(NpcTrainerKey.fromEntity(entity.copyWith(trainerId: 11))),
      );
      expect(
        key,
        isNot(NpcTrainerKey.fromEntity(entity.copyWith(spellId: 21))),
      );
      expect(brief.key, key);
    });

    test('CreatureId 使用物理 int 标量定位', () {
      const entity = CreatureDefaultTrainerEntity(
        creatureId: 10,
        trainerId: 20,
      );
      final key = entity.creatureId;
      final same = (entity.copyWith(trainerId: 21)).creatureId;

      expect(key, same);
      expect(key.hashCode, same.hashCode);
      expect(key, isNot((entity.copyWith(creatureId: 11)).creatureId));
    });
  });

  group('repository write contracts', () {
    test('trainer UPDATE 使用完整旧 key 并写入 candidate 全部十列', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestNpcTrainerRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );
      const originalKey = NpcTrainerKey(trainerId: 10, spellId: 20);
      const candidate = NpcTrainerEntity(
        trainerId: 11,
        spellId: 21,
        moneyCost: 22,
        reqSkillLine: 23,
        reqSkillRank: 24,
        reqAbility1: 25,
        reqAbility2: 26,
        reqAbility3: 27,
        reqLevel: 28,
        verifiedBuild: 12340,
      );

      await repository.updateNpcTrainer(originalKey, candidate);

      expect(queries, hasLength(1));
      expect(queries.single.bindings, [
        ...candidate.toJson().values,
        originalKey.trainerId,
        originalKey.spellId,
      ]);
    });

    test('default trainer UPDATE 使用旧 CreatureId 并写入两列', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestCreatureDefaultTrainerRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );
      const originalKey = 10;
      const candidate = CreatureDefaultTrainerEntity(
        creatureId: 11,
        trainerId: 20,
      );

      await repository.updateCreatureDefaultTrainer(originalKey, candidate);

      expect(queries.single.bindings, [
        ...candidate.toJson().values,
        originalKey,
      ]);
    });

    test('UPDATE 和 DELETE 零行结果报告旧记录不存在', () async {
      final laconic = Laconic(_RecordingDriver(affectedRows: 0));
      final trainerRepository = _TestNpcTrainerRepository(laconic);
      final relationRepository = _TestCreatureDefaultTrainerRepository(laconic);
      const trainerKey = NpcTrainerKey(trainerId: 10, spellId: 20);
      const relationKey = 10;

      await expectLater(
        trainerRepository.updateNpcTrainer(
          trainerKey,
          const NpcTrainerEntity(),
        ),
        throwsA(isA<StateError>()),
      );
      await expectLater(
        trainerRepository.destroyNpcTrainer(trainerKey),
        throwsA(isA<StateError>()),
      );
      await expectLater(
        relationRepository.updateCreatureDefaultTrainer(
          relationKey,
          const CreatureDefaultTrainerEntity(),
        ),
        throwsA(isA<StateError>()),
      );
      await expectLater(
        relationRepository.destroyCreatureDefaultTrainer(relationKey),
        throwsA(isA<StateError>()),
      );
    });

    test('Brief 查询显式选择展示列和 key，并使用分页', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestNpcTrainerRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );

      await repository.getBriefNpcTrainers(10, page: 2);

      final query = queries.single;
      expect(query.sql, isNot(contains('ts.*')));
      expect(query.sql, isNot(contains('ReqSkillRank')));
      expect(query.sql, isNot(contains('VerifiedBuild')));
      expect(query.sql.toLowerCase(), contains('limit ? offset ?'));
      expect(query.bindings.sublist(query.bindings.length - 2), [50, 50]);
    });
  });

  group('NpcTrainer inline editing identity', () {
    late _FakeNpcTrainerRepository repository;
    late _FakeCreatureDefaultTrainerRepository relationRepository;

    setUp(() {
      repository = _FakeNpcTrainerRepository([
        const NpcTrainerEntity(trainerId: 100, spellId: 20),
      ]);
      relationRepository = _FakeCreatureDefaultTrainerRepository({
        10: const CreatureDefaultTrainerEntity(creatureId: 10, trainerId: 100),
        12: const CreatureDefaultTrainerEntity(creatureId: 12, trainerId: 200),
      });
      GetIt.instance.registerSingleton<NpcTrainerRepository>(repository);
      GetIt.instance.registerSingleton<CreatureDefaultTrainerRepository>(
        relationRepository,
      );
    });

    tearDown(() async => GetIt.instance.reset());

    test('修改联合键仍用旧 key，成功后清空当前范围编辑状态', () async {
      final viewModel = NpcTrainerCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 100);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      const originalKey = NpcTrainerKey(trainerId: 100, spellId: 20);
      expect(viewModel.editingKey.value, originalKey);

      viewModel.trainerIdController.init(101);
      viewModel.spellIdController.init(21);
      await viewModel.persist();

      expect(repository.updateKeys, [originalKey]);
      expect(repository.rows.single.trainerId, 101);
      expect(repository.rows.single.spellId, 21);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.selectedKey.value, isNull);
      expect(viewModel.editingKey.value, isNull);
    });

    test('保存失败保留 editingKey，修正后仍按旧 key 重试', () async {
      final viewModel = NpcTrainerCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 100);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      const originalKey = NpcTrainerKey(trainerId: 100, spellId: 20);
      repository.failUpdates = true;
      viewModel.spellIdController.init(21);

      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, originalKey);

      repository.failUpdates = false;
      await viewModel.persist();
      expect(repository.updateKeys, [originalKey, originalKey]);
    });

    test('父范围切换和新建都清空旧行身份', () async {
      final viewModel = NpcTrainerCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 100);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);

      await viewModel.setParentKey(200);
      expect(viewModel.parentKey.value, 200);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.selectedKey.value, isNull);

      await viewModel.create();
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.trainerIdController.collect(), 200);
      viewModel.spellIdController.init(50);
      await viewModel.persist();
      expect(repository.storeCount, 1);
    });
  });

  test('validation、UI 和 Repository 边界正确', () {
    final validation = _NpcTrainerValidation();
    expect(
      () => validation.validateNpcTrainerFields(
        const NpcTrainerEntity(trainerId: 1, spellId: 2, reqLevel: 256),
      ),
      throwsA(isA<StateError>()),
    );
    final repository = File(
      'lib/repository/npc_trainer_repository.dart',
    ).readAsStringSync();
    final relationRepository = File(
      'lib/repository/creature_default_trainer_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/creature_template/npc_trainer_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/creature_template/npc_trainer_view.dart',
    ).readAsStringSync();

    expect(repository, isNot(contains('saveNpcTrainer')));
    expect(repository, isNot(contains("json.remove('TrainerId')")));
    expect(relationRepository, isNot(contains('saveCreatureDefaultTrainer')));
    expect(
      viewModel,
      contains('final editingKey = signal<NpcTrainerKey?>(null)'),
    );
    expect(viewModel, contains('Future<void> destroy('));
    expect(view, isNot(contains('readOnly:')));
    expect(view, contains('FoxyPagination('));
  });
}

class _FakeNpcTrainerRepository extends NpcTrainerRepository {
  final List<NpcTrainerEntity> rows;
  bool failUpdates = false;
  int storeCount = 0;
  final updateKeys = <NpcTrainerKey>[];

  _FakeNpcTrainerRepository(this.rows);

  @override
  Future<int> countNpcTrainers(int trainerId) async {
    return rows.where((row) => row.trainerId == trainerId).length;
  }

  @override
  Future<List<BriefNpcTrainerEntity>> getBriefNpcTrainers(
    int trainerId, {
    int page = 1,
  }) async {
    return rows
        .where((row) => row.trainerId == trainerId)
        .map(
          (row) => BriefNpcTrainerEntity(
            trainerId: row.trainerId,
            spellId: row.spellId,
            moneyCost: row.moneyCost,
            reqSkillLine: row.reqSkillLine,
            reqLevel: row.reqLevel,
          ),
        )
        .toList();
  }

  @override
  Future<NpcTrainerEntity?> getNpcTrainer(NpcTrainerKey key) async {
    for (final row in rows) {
      if (NpcTrainerKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> storeNpcTrainer(NpcTrainerEntity trainer) async {
    storeCount++;
    rows.add(trainer);
  }

  @override
  Future<void> updateNpcTrainer(
    NpcTrainerKey originalKey,
    NpcTrainerEntity trainer,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => NpcTrainerKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = trainer;
  }
}

class _FakeCreatureDefaultTrainerRepository
    extends CreatureDefaultTrainerRepository {
  final Map<int, CreatureDefaultTrainerEntity> rows;

  _FakeCreatureDefaultTrainerRepository(this.rows);

  @override
  Future<CreatureDefaultTrainerEntity?> getCreatureDefaultTrainer(
    int key,
  ) async {
    return rows[key];
  }
}

class _NpcTrainerValidation
    with ViewModelValidationMixin, NpcTrainerValidationMixin {}

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

class _TestNpcTrainerRepository extends NpcTrainerRepository {
  @override
  final Laconic laconic;

  _TestNpcTrainerRepository(this.laconic);
}

class _TestCreatureDefaultTrainerRepository
    extends CreatureDefaultTrainerRepository {
  @override
  final Laconic laconic;

  _TestCreatureDefaultTrainerRepository(this.laconic);
}
