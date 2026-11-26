import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/repository/creature_quest_ender_repository.dart';
import 'package:foxy/repository/creature_quest_starter_repository.dart';
import 'package:foxy/view_model/creature_quest_ender_linked_list_view_model.dart';
import 'package:foxy/view_model/creature_quest_starter_linked_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'in_memory_row_editing.dart';
import 'inline_editing_expectations.dart';
import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Creature quest starter and ender keys and brief entities include id and quest', () {
    const starter = CreatureQuestStarterEntity(id: 10, quest: 20);
    const ender = CreatureQuestEnderEntity(id: 10, quest: 20);
    final starterKey = CreatureQuestStarterKey.fromEntity(starter);
    final enderKey = CreatureQuestEnderKey.fromEntity(ender);

    expectRowKeyEquality(
      starterKey,
      CreatureQuestStarterKey.fromEntity,
      sameKeyRow: starter.copyWith(),
      differentKeyRows: [starter.copyWith(id: 11), starter.copyWith(quest: 21)],
    );
    expect(
      const BriefCreatureQuestStarterEntity(id: 10, quest: 20).key,
      starterKey,
    );

    expectRowKeyEquality(
      enderKey,
      CreatureQuestEnderKey.fromEntity,
      sameKeyRow: ender.copyWith(),
      differentKeyRows: [ender.copyWith(id: 11), ender.copyWith(quest: 21)],
    );
    expect(
      const BriefCreatureQuestEnderEntity(id: 10, quest: 20).key,
      enderKey,
    );
  });

  group('CreatureQuestStarterRepository write contract', () {
    testRepositoryWrites(
      createRepository: _TestStarterRepository.new,
      originalKey: const CreatureQuestStarterKey(id: 10, quest: 20),
      candidate: const CreatureQuestStarterEntity(id: 11, quest: 21),
      missingCandidate: const CreatureQuestStarterEntity(),
      update: (repository, key, row) =>
          repository.updateCreatureQuestStarter(key, row),
      destroy: (repository, key) => repository.destroyCreatureQuestStarter(key),
      expectedBindings: [11, 21, 10, 20],
    );

    testBriefPagination(
      queryPageTwo: (laconic) =>
          _TestStarterRepository(laconic)
              .getBriefCreatureQuestStarters(20, page: 2),
      tableAlias: 'cqs',
    );
  });

  group('CreatureQuestEnderRepository write contract', () {
    testRepositoryWrites(
      createRepository: _TestEnderRepository.new,
      originalKey: const CreatureQuestEnderKey(id: 30, quest: 40),
      candidate: const CreatureQuestEnderEntity(id: 31, quest: 41),
      missingCandidate: const CreatureQuestEnderEntity(),
      update: (repository, key, row) =>
          repository.updateCreatureQuestEnder(key, row),
      destroy: (repository, key) => repository.destroyCreatureQuestEnder(key),
      expectedBindings: [31, 41, 30, 40],
    );
  });

  group('inline editing identity', () {
    tearDown(() async => GetIt.instance.reset());

    test(
      'A failed quest starter update preserves the old key for retry',
      () async {
        final repository = _FakeStarterRepository([
          const CreatureQuestStarterEntity(id: 10, quest: 20),
        ]);
        GetIt.instance.registerSingleton<CreatureQuestStarterRepository>(
          repository,
        );
        final viewModel = CreatureQuestStarterLinkedListViewModel();
        addTearDown(viewModel.dispose);
        await viewModel.initSignals(linkKey: 20);
        viewModel.selectedKey.value = viewModel.items.value[0].key;
        await viewModel.edit(viewModel.selectedKey.value!);
        const oldKey = CreatureQuestStarterKey(id: 10, quest: 20);
        viewModel.idController.init(11);
        viewModel.questController.init(21);
        await expectSaveRetry(
          repository: repository,
          originalKey: oldKey,
          editingKey: viewModel.editingKey,
          persist: viewModel.persist,
        );
        expect(repository.rows.single.toJson(), {'id': 11, 'quest': 21});
        expect(viewModel.editingKey.value, isNull);
      },
    );

    test(
      'A failed quest ender update preserves the old key for retry',
      () async {
        final repository = _FakeEnderRepository([
          const CreatureQuestEnderEntity(id: 10, quest: 20),
        ]);
        GetIt.instance.registerSingleton<CreatureQuestEnderRepository>(
          repository,
        );
        final viewModel = CreatureQuestEnderLinkedListViewModel();
        addTearDown(viewModel.dispose);
        await viewModel.initSignals(linkKey: 20);
        viewModel.selectedKey.value = viewModel.items.value[0].key;
        await viewModel.edit(viewModel.selectedKey.value!);
        const oldKey = CreatureQuestEnderKey(id: 10, quest: 20);
        viewModel.idController.init(11);
        viewModel.questController.init(21);
        await expectSaveRetry(
          repository: repository,
          originalKey: oldKey,
          editingKey: viewModel.editingKey,
          persist: viewModel.persist,
        );
        expect(repository.rows.single.toJson(), {'id': 11, 'quest': 21});
        expect(viewModel.editingKey.value, isNull);
      },
    );
  });
}

class _FakeEnderRepository extends CreatureQuestEnderRepository
    with InMemoryRowEditing<CreatureQuestEnderEntity, CreatureQuestEnderKey> {
  @override
  final List<CreatureQuestEnderEntity> rows;
  _FakeEnderRepository(this.rows);

  @override
  CreatureQuestEnderKey keyOf(CreatureQuestEnderEntity row) =>
      CreatureQuestEnderKey.fromEntity(row);

  @override
  Future<int> countCreatureQuestEnders(int questId) async =>
      rows.where((row) => row.quest == questId).length;

  @override
  Future<List<BriefCreatureQuestEnderEntity>> getBriefCreatureQuestEnders(
    int questId, {
    int page = 1,
  }) async => rows
      .where((row) => row.quest == questId)
      .map((row) => BriefCreatureQuestEnderEntity(id: row.id, quest: row.quest))
      .toList();

  @override
  Future<CreatureQuestEnderEntity?> getCreatureQuestEnder(
    CreatureQuestEnderKey key,
  ) async => findRow(key);

  @override
  Future<void> updateCreatureQuestEnder(
    CreatureQuestEnderKey originalKey,
    CreatureQuestEnderEntity model,
  ) async => updateRow(originalKey, model);
}

class _FakeStarterRepository extends CreatureQuestStarterRepository
    with
        InMemoryRowEditing<
          CreatureQuestStarterEntity,
          CreatureQuestStarterKey
        > {
  @override
  final List<CreatureQuestStarterEntity> rows;
  _FakeStarterRepository(this.rows);

  @override
  CreatureQuestStarterKey keyOf(CreatureQuestStarterEntity row) =>
      CreatureQuestStarterKey.fromEntity(row);

  @override
  Future<int> countCreatureQuestStarters(int questId) async =>
      rows.where((row) => row.quest == questId).length;

  @override
  Future<List<BriefCreatureQuestStarterEntity>> getBriefCreatureQuestStarters(
    int questId, {
    int page = 1,
  }) async => rows
      .where((row) => row.quest == questId)
      .map(
        (row) => BriefCreatureQuestStarterEntity(id: row.id, quest: row.quest),
      )
      .toList();

  @override
  Future<CreatureQuestStarterEntity?> getCreatureQuestStarter(
    CreatureQuestStarterKey key,
  ) async => findRow(key);

  @override
  Future<void> updateCreatureQuestStarter(
    CreatureQuestStarterKey originalKey,
    CreatureQuestStarterEntity model,
  ) async => updateRow(originalKey, model);
}

class _TestEnderRepository extends CreatureQuestEnderRepository {
  @override
  final Laconic laconic;
  _TestEnderRepository(this.laconic);
}

class _TestStarterRepository extends CreatureQuestStarterRepository {
  @override
  final Laconic laconic;
  _TestStarterRepository(this.laconic);
}
