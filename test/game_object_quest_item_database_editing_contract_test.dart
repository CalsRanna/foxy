import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_game_object_quest_item_entity.dart';
import 'package:foxy/entity/game_object_quest_item_entity.dart';
import 'package:foxy/entity/game_object_quest_item_key.dart';
import 'package:foxy/page/game_object/game_object_quest_item_view_model.dart';
import 'package:foxy/repository/game_object_quest_item_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('GameObjectQuestItemKey 和 Brief 完整覆盖两列主键', () {
    const entity = GameObjectQuestItemEntity(gameObjectEntry: 10, idx: 2);
    final key = GameObjectQuestItemKey.fromEntity(entity);
    final same = GameObjectQuestItemKey.fromEntity(
      entity.copyWith(itemId: 123),
    );
    const brief = BriefGameObjectQuestItemEntity(gameObjectEntry: 10, idx: 2);

    expect(key, same);
    expect(key.hashCode, same.hashCode);
    expect(
      key,
      isNot(
        GameObjectQuestItemKey.fromEntity(entity.copyWith(gameObjectEntry: 11)),
      ),
    );
    expect(
      key,
      isNot(GameObjectQuestItemKey.fromEntity(entity.copyWith(idx: 3))),
    );
    expect(brief.key, key);
  });

  test('UPDATE 使用完整旧 key 定位并写入 candidate 四列', () async {
    final queries = <LaconicQuery>[];
    final repository = _TestRepository(
      Laconic(_RecordingDriver(), listen: queries.add),
    );
    const oldKey = GameObjectQuestItemKey(gameObjectEntry: 10, idx: 2);
    const candidate = GameObjectQuestItemEntity(
      gameObjectEntry: 11,
      idx: 3,
      itemId: 123,
      verifiedBuild: 12340,
    );

    await repository.updateGameObjectQuestItem(oldKey, candidate);

    expect(queries.single.bindings, [
      ...candidate.toJson().values,
      oldKey.gameObjectEntry,
      oldKey.idx,
    ]);
  });

  test('UPDATE、DELETE 零行报错且 Brief 查询稳定分页', () async {
    final missingRepository = _TestRepository(
      Laconic(_RecordingDriver(affectedRows: 0)),
    );
    const key = GameObjectQuestItemKey(gameObjectEntry: 10, idx: 2);
    await expectLater(
      missingRepository.updateGameObjectQuestItem(
        key,
        const GameObjectQuestItemEntity(),
      ),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      missingRepository.destroyGameObjectQuestItem(key),
      throwsA(isA<StateError>()),
    );

    final queries = <LaconicQuery>[];
    final repository = _TestRepository(
      Laconic(_RecordingDriver(), listen: queries.add),
    );
    await repository.getBriefGameObjectQuestItems(10, page: 2);
    expect(queries.single.sql, isNot(contains('gq.*')));
    expect(queries.single.sql.toLowerCase(), contains('order by'));
    expect(
      queries.single.bindings.sublist(queries.single.bindings.length - 2),
      [50, 50],
    );
  });

  group('inline editing identity', () {
    late _FakeRepository repository;

    setUp(() {
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
    });

    tearDown(() async => GetIt.instance.reset());

    test('修改两列 key 仍按旧 key 更新，失败时保留并可重试', () async {
      final viewModel = GameObjectQuestItemViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(gameObjectId: 10);
      viewModel.selectRow(0);
      expect(await viewModel.edit(), isTrue);
      const oldKey = GameObjectQuestItemKey(gameObjectEntry: 10, idx: 2);
      expect(viewModel.editingKey.value, oldKey);
      viewModel.gameObjectIdController.init(11);
      viewModel.idxController.init(3);
      repository.failUpdates = true;

      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, oldKey);

      repository.failUpdates = false;
      await viewModel.persist();
      expect(repository.updateKeys, [oldKey, oldKey]);
      expect(repository.rows.single.gameObjectEntry, 11);
      expect(repository.rows.single.idx, 3);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });

    test('切换父范围和新建都会清空旧行身份', () async {
      final viewModel = GameObjectQuestItemViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(gameObjectId: 10);
      viewModel.selectRow(0);
      await viewModel.edit();

      await viewModel.setParentGameObjectEntry(12);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.selectedIndex.value, isNull);
      expect(await viewModel.create(), isTrue);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.gameObjectIdController.collect(), 12);
    });
  });

  test('UI、Full Entity 和 ViewModel 遵守迁移边界', () {
    final entity = File(
      'lib/entity/game_object_quest_item_entity.dart',
    ).readAsStringSync();
    final repository = File(
      'lib/repository/game_object_quest_item_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/game_object/game_object_quest_item_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/game_object/game_object_quest_item_view.dart',
    ).readAsStringSync();

    expect(entity, isNot(contains('itemName')));
    expect(repository, isNot(contains('saveGameObjectQuestItem')));
    expect(
      viewModel,
      contains('final editingKey = signal<GameObjectQuestItemKey?>(null)'),
    );
    expect(viewModel, contains('destroyGameObjectQuestItem(selected.key)'));
    expect(view, isNot(contains('readOnly:')));
    expect(view, contains('FoxyPagination('));
  });
}

class _FakeRepository extends GameObjectQuestItemRepository {
  final List<GameObjectQuestItemEntity> rows;
  bool failUpdates = false;
  final updateKeys = <GameObjectQuestItemKey>[];

  _FakeRepository(this.rows);

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
  ) async {
    for (final row in rows) {
      if (GameObjectQuestItemKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> updateGameObjectQuestItem(
    GameObjectQuestItemKey originalKey,
    GameObjectQuestItemEntity questItem,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => GameObjectQuestItemKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = questItem;
  }
}

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

class _TestRepository extends GameObjectQuestItemRepository {
  @override
  final Laconic laconic;

  _TestRepository(this.laconic);
}
