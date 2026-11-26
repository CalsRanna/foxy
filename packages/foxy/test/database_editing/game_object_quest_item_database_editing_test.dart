import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/game_object_quest_item_entity.dart';
import 'package:foxy/repository/game_object_quest_item_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/view_model/game_object_quest_item_linked_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'in_memory_row_editing.dart';
import 'inline_editing_expectations.dart';
import 'repository_contract.dart';
import 'row_key_expectations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('GameObjectQuestItemKey and its brief entity include both primary key fields', () {
    const entity = GameObjectQuestItemEntity(gameObjectEntry: 10, idx: 2);
    final key = GameObjectQuestItemKey.fromEntity(entity);
    const brief = BriefGameObjectQuestItemEntity(gameObjectEntry: 10, idx: 2);

    expectRowKeyEquality(
      key,
      GameObjectQuestItemKey.fromEntity,
      sameKeyRow: entity.copyWith(itemId: 123),
      differentKeyRows: [
        entity.copyWith(gameObjectEntry: 11),
        entity.copyWith(idx: 3),
      ],
    );
    expect(brief.key, key);
  });

  group('GameObjectQuestItemRepository write contract', () {
    const oldKey = GameObjectQuestItemKey(gameObjectEntry: 10, idx: 2);
    const candidate = GameObjectQuestItemEntity(
      gameObjectEntry: 11,
      idx: 3,
      itemId: 123,
      verifiedBuild: 12340,
    );

    testRepositoryWrites(
      createRepository: _TestRepository.new,
      originalKey: oldKey,
      candidate: candidate,
      missingCandidate: const GameObjectQuestItemEntity(),
      update: (repository, key, row) =>
          repository.updateGameObjectQuestItem(key, row),
      destroy: (repository, key) => repository.destroyGameObjectQuestItem(key),
      expectedBindings: [
        ...candidate.toJson().values,
        oldKey.gameObjectEntry,
        oldKey.idx,
      ],
    );

    testBriefPagination(
      queryPageTwo: (laconic) =>
          _TestRepository(laconic).getBriefGameObjectQuestItems(10, page: 2),
      tableAlias: 'gq',
    );
  });

  group('inline editing identity', () {
    late _FakeRepository repository;

    late GameObjectQuestItemLinkedListViewModel viewModel;

    setUp(() async {
      repository = _FakeRepository([
        const GameObjectQuestItemEntity(
          gameObjectEntry: 10,
          idx: 2,
          itemId: 123,
        ),
      ]);
      GetIt.instance.registerSingleton<GameObjectQuestItemRepository>(
        repository,
      );
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());

      viewModel = GameObjectQuestItemLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(linkKey: 10);
      viewModel.selectedKey.value = viewModel.items.value.single.key;
      await viewModel.edit(viewModel.selectedKey.value!);
    });

    tearDown(() async => GetIt.instance.reset());

    test('Changing both key fields updates by the old key and a failed save preserves it for retry', () async {
      const oldKey = GameObjectQuestItemKey(gameObjectEntry: 10, idx: 2);
      expect(viewModel.editingKey.value, oldKey);
      viewModel.gameObjectEntryController.init(11);
      viewModel.idxController.init(3);

      await expectSaveRetry(
        repository: repository,
        originalKey: oldKey,
        editingKey: viewModel.editingKey,
        persist: viewModel.persist,
      );
      expect(repository.rows.single.gameObjectEntry, 11);
      expect(repository.rows.single.idx, 3);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });

    test(
      'Changing the parent scope and creating clear the previous row identity',
      () async {
        await expectParentChangeAndCreateClearIdentity(
          editingKey: viewModel.editingKey,
          selectedKey: viewModel.selectedKey,
          changeParent: () => viewModel.setLinkKey(12),
          create: viewModel.create,
        );
        expect(viewModel.gameObjectEntryController.collect(), 12);
      },
    );
  });
}

class _FakeRepository extends GameObjectQuestItemRepository
    with InMemoryRowEditing<GameObjectQuestItemEntity, GameObjectQuestItemKey> {
  @override
  final List<GameObjectQuestItemEntity> rows;

  _FakeRepository(this.rows);

  @override
  GameObjectQuestItemKey keyOf(GameObjectQuestItemEntity row) =>
      GameObjectQuestItemKey.fromEntity(row);

  @override
  Future<int> countGameObjectQuestItems(int gameObjectEntry) async {
    return rows.where((row) => row.gameObjectEntry == gameObjectEntry).length;
  }

  @override
  Future<GameObjectQuestItemEntity> createGameObjectQuestItem(
    int gameObjectEntry,
  ) async {
    return GameObjectQuestItemEntity(gameObjectEntry: gameObjectEntry, idx: 0);
  }

  @override
  Future<List<BriefGameObjectQuestItemEntity>> getBriefGameObjectQuestItems(
    int gameObjectEntry, {
    int page = 1,
  }) async {
    return rows
        .where((row) => row.gameObjectEntry == gameObjectEntry)
        .map(
          (row) => BriefGameObjectQuestItemEntity(
            gameObjectEntry: row.gameObjectEntry,
            idx: row.idx,
            itemId: row.itemId,
            verifiedBuild: row.verifiedBuild,
          ),
        )
        .toList();
  }

  @override
  Future<GameObjectQuestItemEntity?> getGameObjectQuestItem(
    GameObjectQuestItemKey key,
  ) async => findRow(key);

  @override
  Future<void> updateGameObjectQuestItem(
    GameObjectQuestItemKey originalKey,
    GameObjectQuestItemEntity questItem,
  ) async => updateRow(originalKey, questItem);
}

class _TestRepository extends GameObjectQuestItemRepository {
  @override
  final Laconic laconic;

  _TestRepository(this.laconic);
}
