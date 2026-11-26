import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_default_trainer_entity.dart';
import 'package:foxy/entity/npc_trainer_entity.dart';
import 'package:foxy/repository/creature_default_trainer_repository.dart';
import 'package:foxy/repository/npc_trainer_repository.dart';
import 'package:foxy/use_case/creature_template/resolve_npc_trainer_parent_use_case.dart';
import 'package:foxy/view_model/npc_trainer_linked_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'in_memory_row_editing.dart';
import 'inline_editing_expectations.dart';
import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('trainer row locators and Brief entity', () {
    test('NpcTrainerKey includes TrainerId and SpellId in value equality', () {
      const entity = NpcTrainerEntity(trainerId: 10, spellId: 20);
      final key = NpcTrainerKey.fromEntity(entity);
      const brief = BriefNpcTrainerEntity(trainerId: 10, spellId: 20);

      expectRowKeyEquality(
        key,
        NpcTrainerKey.fromEntity,
        sameKeyRow: entity.copyWith(moneyCost: 30),
        differentKeyRows: [
          entity.copyWith(trainerId: 11),
          entity.copyWith(spellId: 21),
        ],
      );
      expect(brief.key, key);
    });

    test('CreatureId identifies rows using the physical int value', () {
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
    group('NpcTrainerRepository', () {
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

      testRepositoryWrites(
        createRepository: _TestNpcTrainerRepository.new,
        originalKey: originalKey,
        candidate: candidate,
        missingCandidate: const NpcTrainerEntity(),
        update: (repository, key, row) => repository.updateNpcTrainer(key, row),
        destroy: (repository, key) => repository.destroyNpcTrainer(key),
        expectedBindings: [
          ...candidate.toJson().values,
          originalKey.trainerId,
          originalKey.spellId,
        ],
      );
    });

    group('CreatureDefaultTrainerRepository', () {
      const originalKey = 10;
      const candidate = CreatureDefaultTrainerEntity(
        creatureId: 11,
        trainerId: 20,
      );

      testRepositoryWrites(
        createRepository: _TestCreatureDefaultTrainerRepository.new,
        originalKey: originalKey,
        candidate: candidate,
        missingCandidate: const CreatureDefaultTrainerEntity(),
        update: (repository, key, row) =>
            repository.updateCreatureDefaultTrainer(key, row),
        destroy: (repository, key) =>
            repository.destroyCreatureDefaultTrainer(key),
        expectedBindings: [...candidate.toJson().values, originalKey],
      );
    });

    testBriefPagination(
      queryPageTwo: (laconic) =>
          _TestNpcTrainerRepository(laconic).getBriefNpcTrainers(10, page: 2),
      tableAlias: 'ts',
      verifyQuery: (query) {
        expect(query.sql, isNot(contains('ReqSkillRank')));
        expect(query.sql, isNot(contains('VerifiedBuild')));
      },
    );
  });

  group('NpcTrainer inline editing identity', () {
    late _FakeNpcTrainerRepository repository;
    late _FakeCreatureDefaultTrainerRepository relationRepository;

    late NpcTrainerLinkedListViewModel viewModel;

    setUp(() async {
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
      GetIt.instance.registerSingleton<ResolveNpcTrainerParentUseCase>(
        ResolveNpcTrainerParentUseCase(repository: relationRepository),
      );

      viewModel = NpcTrainerLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 100);
      viewModel.selectedKey.value = viewModel.items.value.single.key;
      await viewModel.edit(viewModel.selectedKey.value!);
    });

    tearDown(() async => GetIt.instance.reset());

    test('Changing a composite key updates by the old key and clears the current edit state on success', () async {
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

    test('A failed save retains editingKey and the corrected retry uses the old key', () async {
      const originalKey = NpcTrainerKey(trainerId: 100, spellId: 20);
      viewModel.spellIdController.init(21);

      await expectSaveRetry(
        repository: repository,
        originalKey: originalKey,
        editingKey: viewModel.editingKey,
        persist: viewModel.persist,
      );
    });

    test(
      'Changing the parent and creating clear the old row identity',
      () async {
        await expectParentChangeAndCreateClearIdentity(
          editingKey: viewModel.editingKey,
          selectedKey: viewModel.selectedKey,
          changeParent: () async {
            await viewModel.setLinkKey(200);
            expect(viewModel.linkKey.value, 200);
          },
          create: viewModel.create,
        );
        expect(viewModel.trainerIdController.collect(), 200);
        viewModel.spellIdController.init(50);
        await viewModel.persist();
        expect(repository.storeCount, 1);
      },
    );
  });
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

class _FakeNpcTrainerRepository extends NpcTrainerRepository
    with InMemoryRowEditing<NpcTrainerEntity, NpcTrainerKey> {
  @override
  final List<NpcTrainerEntity> rows;
  int storeCount = 0;

  _FakeNpcTrainerRepository(this.rows);

  @override
  NpcTrainerKey keyOf(NpcTrainerEntity row) => NpcTrainerKey.fromEntity(row);

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
  Future<NpcTrainerEntity?> getNpcTrainer(NpcTrainerKey key) async =>
      findRow(key);

  @override
  Future<void> storeNpcTrainer(NpcTrainerEntity trainer) async {
    storeCount++;
    rows.add(trainer);
  }

  @override
  Future<void> updateNpcTrainer(
    NpcTrainerKey originalKey,
    NpcTrainerEntity trainer,
  ) async => updateRow(originalKey, trainer);
}

class _TestCreatureDefaultTrainerRepository
    extends CreatureDefaultTrainerRepository {
  @override
  final Laconic laconic;

  _TestCreatureDefaultTrainerRepository(this.laconic);
}

class _TestNpcTrainerRepository extends NpcTrainerRepository {
  @override
  final Laconic laconic;

  _TestNpcTrainerRepository(this.laconic);
}
