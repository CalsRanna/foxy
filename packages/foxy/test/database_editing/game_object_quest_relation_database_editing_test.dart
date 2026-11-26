import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy/entity/game_object_quest_starter_entity.dart';
import 'package:foxy/repository/game_object_quest_ender_repository.dart';
import 'package:foxy/repository/game_object_quest_starter_repository.dart';
import 'package:foxy/view_model/game_object_quest_ender_linked_list_view_model.dart';
import 'package:foxy/view_model/game_object_quest_starter_linked_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'in_memory_row_editing.dart';
import 'inline_editing_expectations.dart';
import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'Quest starter and ender keys and brief entities include id and quest',
    () {
      const starter = GameObjectQuestStarterEntity(id: 10, quest: 20);
      const ender = GameObjectQuestEnderEntity(id: 10, quest: 20);
      final starterKey = GameObjectQuestStarterKey.fromEntity(starter);
      final enderKey = GameObjectQuestEnderKey.fromEntity(ender);

      expectRowKeyEquality(
        starterKey,
        GameObjectQuestStarterKey.fromEntity,
        sameKeyRow: starter.copyWith(),
        differentKeyRows: [
          starter.copyWith(id: 11),
          starter.copyWith(quest: 21),
        ],
      );
      expect(
        const BriefGameObjectQuestStarterEntity(id: 10, quest: 20).key,
        starterKey,
      );

      expectRowKeyEquality(
        enderKey,
        GameObjectQuestEnderKey.fromEntity,
        sameKeyRow: ender.copyWith(),
        differentKeyRows: [ender.copyWith(id: 11), ender.copyWith(quest: 21)],
      );
      expect(
        const BriefGameObjectQuestEnderEntity(id: 10, quest: 20).key,
        enderKey,
      );
    },
  );

  group('GameObjectQuestStarterRepository write contract', () {
    testRepositoryWrites(
      createRepository: _TestStarterRepository.new,
      originalKey: const GameObjectQuestStarterKey(id: 10, quest: 20),
      candidate: const GameObjectQuestStarterEntity(id: 11, quest: 21),
      missingCandidate: const GameObjectQuestStarterEntity(),
      update: (repository, key, row) =>
          repository.updateGameObjectQuestStarter(key, row),
      destroy: (repository, key) =>
          repository.destroyGameObjectQuestStarter(key),
      expectedBindings: [11, 21, 10, 20],
    );

    testBriefPagination(
      queryPageTwo: (laconic) =>
          _TestStarterRepository(laconic)
              .getBriefGameObjectQuestStarters(20, page: 2),
      tableAlias: 'gos',
    );
  });

  group('GameObjectQuestEnderRepository write contract', () {
    testRepositoryWrites(
      createRepository: _TestEnderRepository.new,
      originalKey: const GameObjectQuestEnderKey(id: 30, quest: 40),
      candidate: const GameObjectQuestEnderEntity(id: 31, quest: 41),
      missingCandidate: const GameObjectQuestEnderEntity(),
      update: (repository, key, row) =>
          repository.updateGameObjectQuestEnder(key, row),
      destroy: (repository, key) => repository.destroyGameObjectQuestEnder(key),
      expectedBindings: [31, 41, 30, 40],
    );

    testBriefPagination(
      queryPageTwo: (laconic) =>
          _TestEnderRepository(laconic)
              .getBriefGameObjectQuestEnders(20, page: 2),
      tableAlias: 'goe',
    );
  });

  group('inline editing identity', () {
    tearDown(() async => GetIt.instance.reset());

    test('A failed composite key change on a quest starter preserves its identity for retry', () async {
      final repository = _FakeStarterRepository([
        const GameObjectQuestStarterEntity(id: 10, quest: 20),
      ]);
      GetIt.instance.registerSingleton<GameObjectQuestStarterRepository>(
        repository,
      );
      final viewModel = GameObjectQuestStarterLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 20);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      const oldKey = GameObjectQuestStarterKey(id: 10, quest: 20);
      viewModel.idController.init(11);
      viewModel.questController.init(21);

      await expectSaveRetry(
        repository: repository,
        originalKey: oldKey,
        editingKey: viewModel.editingKey,
        persist: viewModel.persist,
      );

      expect(repository.rows.single.toJson(), {'id': 11, 'quest': 21});
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });

    test('A failed composite key change on a quest ender preserves its identity for retry', () async {
      final repository = _FakeEnderRepository([
        const GameObjectQuestEnderEntity(id: 10, quest: 20),
      ]);
      GetIt.instance.registerSingleton<GameObjectQuestEnderRepository>(
        repository,
      );
      final viewModel = GameObjectQuestEnderLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 20);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      const oldKey = GameObjectQuestEnderKey(id: 10, quest: 20);
      viewModel.idController.init(11);
      viewModel.questController.init(21);

      await expectSaveRetry(
        repository: repository,
        originalKey: oldKey,
        editingKey: viewModel.editingKey,
        persist: viewModel.persist,
      );

      expect(repository.rows.single.toJson(), {'id': 11, 'quest': 21});
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });
  });
}

class _FakeEnderRepository extends GameObjectQuestEnderRepository
    with
        InMemoryRowEditing<
          GameObjectQuestEnderEntity,
          GameObjectQuestEnderKey
        > {
  @override
  final List<GameObjectQuestEnderEntity> rows;

  _FakeEnderRepository(this.rows);

  @override
  GameObjectQuestEnderKey keyOf(GameObjectQuestEnderEntity row) =>
      GameObjectQuestEnderKey.fromEntity(row);

  @override
  Future<int> countGameObjectQuestEnders(int questId) async =>
      rows.where((row) => row.quest == questId).length;

  @override
  Future<List<BriefGameObjectQuestEnderEntity>> getBriefGameObjectQuestEnders(
    int questId, {
    int page = 1,
  }) async {
    return rows
        .where((row) => row.quest == questId)
        .map(
          (row) =>
              BriefGameObjectQuestEnderEntity(id: row.id, quest: row.quest),
        )
        .toList();
  }

  @override
  Future<GameObjectQuestEnderEntity?> getGameObjectQuestEnder(
    GameObjectQuestEnderKey key,
  ) async => findRow(key);

  @override
  Future<void> updateGameObjectQuestEnder(
    GameObjectQuestEnderKey originalKey,
    GameObjectQuestEnderEntity model,
  ) async => updateRow(originalKey, model);
}

class _FakeStarterRepository extends GameObjectQuestStarterRepository
    with
        InMemoryRowEditing<
          GameObjectQuestStarterEntity,
          GameObjectQuestStarterKey
        > {
  @override
  final List<GameObjectQuestStarterEntity> rows;

  _FakeStarterRepository(this.rows);

  @override
  GameObjectQuestStarterKey keyOf(GameObjectQuestStarterEntity row) =>
      GameObjectQuestStarterKey.fromEntity(row);

  @override
  Future<int> countGameObjectQuestStarters(int questId) async =>
      rows.where((row) => row.quest == questId).length;

  @override
  Future<List<BriefGameObjectQuestStarterEntity>>
  getBriefGameObjectQuestStarters(int questId, {int page = 1}) async {
    return rows
        .where((row) => row.quest == questId)
        .map(
          (row) =>
              BriefGameObjectQuestStarterEntity(id: row.id, quest: row.quest),
        )
        .toList();
  }

  @override
  Future<GameObjectQuestStarterEntity?> getGameObjectQuestStarter(
    GameObjectQuestStarterKey key,
  ) async => findRow(key);

  @override
  Future<void> updateGameObjectQuestStarter(
    GameObjectQuestStarterKey originalKey,
    GameObjectQuestStarterEntity model,
  ) async => updateRow(originalKey, model);
}

class _TestEnderRepository extends GameObjectQuestEnderRepository {
  @override
  final Laconic laconic;

  _TestEnderRepository(this.laconic);
}

class _TestStarterRepository extends GameObjectQuestStarterRepository {
  @override
  final Laconic laconic;

  _TestStarterRepository(this.laconic);
}
