import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/game_object_quest_ender_entity.dart';
import 'package:foxy/entity/game_object_quest_starter_entity.dart';
import 'package:foxy/page/quest/game_object_quest_ender_collection_editor_view_model.dart';
import 'package:foxy/page/quest/game_object_quest_starter_collection_editor_view_model.dart';
import 'package:foxy/repository/game_object_quest_ender_repository.dart';
import 'package:foxy/repository/game_object_quest_starter_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('开始与结束关系 Key、Brief 完整覆盖 id + quest', () {
    const starter = GameObjectQuestStarterEntity(id: 10, quest: 20);
    const ender = GameObjectQuestEnderEntity(id: 10, quest: 20);
    final starterKey = GameObjectQuestStarterKey.fromEntity(starter);
    final enderKey = GameObjectQuestEnderKey.fromEntity(ender);

    expect(
      starterKey,
      GameObjectQuestStarterKey.fromEntity(starter.copyWith()),
    );
    expect(
      starterKey.hashCode,
      GameObjectQuestStarterKey.fromEntity(starter.copyWith()).hashCode,
    );
    expect(
      starterKey,
      isNot(GameObjectQuestStarterKey.fromEntity(starter.copyWith(id: 11))),
    );
    expect(
      starterKey,
      isNot(GameObjectQuestStarterKey.fromEntity(starter.copyWith(quest: 21))),
    );
    expect(
      const BriefGameObjectQuestStarterEntity(id: 10, quest: 20).key,
      starterKey,
    );

    expect(enderKey, GameObjectQuestEnderKey.fromEntity(ender.copyWith()));
    expect(
      enderKey.hashCode,
      GameObjectQuestEnderKey.fromEntity(ender.copyWith()).hashCode,
    );
    expect(
      enderKey,
      isNot(GameObjectQuestEnderKey.fromEntity(ender.copyWith(id: 11))),
    );
    expect(
      enderKey,
      isNot(GameObjectQuestEnderKey.fromEntity(ender.copyWith(quest: 21))),
    );
    expect(
      const BriefGameObjectQuestEnderEntity(id: 10, quest: 20).key,
      enderKey,
    );
  });

  test('两张表 UPDATE 使用旧 key 并写入完整 candidate', () async {
    final starterQueries = <LaconicQuery>[];
    final starterRepository = _TestStarterRepository(
      Laconic(_RecordingDriver(), listen: starterQueries.add),
    );
    const starterKey = GameObjectQuestStarterKey(id: 10, quest: 20);
    const starterCandidate = GameObjectQuestStarterEntity(id: 11, quest: 21);
    await starterRepository.updateGameObjectQuestStarter(
      starterKey,
      starterCandidate,
    );
    expect(starterQueries.single.bindings, [11, 21, 10, 20]);

    final enderQueries = <LaconicQuery>[];
    final enderRepository = _TestEnderRepository(
      Laconic(_RecordingDriver(), listen: enderQueries.add),
    );
    const enderKey = GameObjectQuestEnderKey(id: 30, quest: 40);
    const enderCandidate = GameObjectQuestEnderEntity(id: 31, quest: 41);
    await enderRepository.updateGameObjectQuestEnder(enderKey, enderCandidate);
    expect(enderQueries.single.bindings, [31, 41, 30, 40]);
  });

  test('两张表零行写入报错，Brief 查询稳定分页', () async {
    final starterMissing = _TestStarterRepository(
      Laconic(_RecordingDriver(affectedRows: 0)),
    );
    const starterKey = GameObjectQuestStarterKey(id: 10, quest: 20);
    await expectLater(
      starterMissing.updateGameObjectQuestStarter(
        starterKey,
        const GameObjectQuestStarterEntity(),
      ),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      starterMissing.destroyGameObjectQuestStarter(starterKey),
      throwsA(isA<StateError>()),
    );

    final enderMissing = _TestEnderRepository(
      Laconic(_RecordingDriver(affectedRows: 0)),
    );
    const enderKey = GameObjectQuestEnderKey(id: 10, quest: 20);
    await expectLater(
      enderMissing.updateGameObjectQuestEnder(
        enderKey,
        const GameObjectQuestEnderEntity(),
      ),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      enderMissing.destroyGameObjectQuestEnder(enderKey),
      throwsA(isA<StateError>()),
    );

    final starterQueries = <LaconicQuery>[];
    final starterRepository = _TestStarterRepository(
      Laconic(_RecordingDriver(), listen: starterQueries.add),
    );
    await starterRepository.getBriefGameObjectQuestStarters(20, page: 2);
    expect(starterQueries.single.sql.toLowerCase(), contains('order by'));
    expect(
      starterQueries.single.bindings.sublist(
        starterQueries.single.bindings.length - 2,
      ),
      [50, 50],
    );

    final enderQueries = <LaconicQuery>[];
    final enderRepository = _TestEnderRepository(
      Laconic(_RecordingDriver(), listen: enderQueries.add),
    );
    await enderRepository.getBriefGameObjectQuestEnders(20, page: 2);
    expect(enderQueries.single.sql.toLowerCase(), contains('order by'));
    expect(
      enderQueries.single.bindings.sublist(
        enderQueries.single.bindings.length - 2,
      ),
      [50, 50],
    );
  });

  group('inline editing identity', () {
    tearDown(() async => GetIt.instance.reset());

    test('开始关系修改双 key 失败后保留旧身份并可重试', () async {
      final repository = _FakeStarterRepository([
        const GameObjectQuestStarterEntity(id: 10, quest: 20),
      ]);
      GetIt.instance.registerSingleton<GameObjectQuestStarterRepository>(
        repository,
      );
      final viewModel = GameObjectQuestStarterCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 20);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      const oldKey = GameObjectQuestStarterKey(id: 10, quest: 20);
      viewModel.idController.init(11);
      viewModel.questController.init(21);
      repository.failUpdates = true;

      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, oldKey);
      repository.failUpdates = false;
      await viewModel.persist();

      expect(repository.updateKeys, [oldKey, oldKey]);
      expect(repository.rows.single.toJson(), {'id': 11, 'quest': 21});
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });

    test('结束关系修改双 key 失败后保留旧身份并可重试', () async {
      final repository = _FakeEnderRepository([
        const GameObjectQuestEnderEntity(id: 10, quest: 20),
      ]);
      GetIt.instance.registerSingleton<GameObjectQuestEnderRepository>(
        repository,
      );
      final viewModel = GameObjectQuestEnderCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 20);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      const oldKey = GameObjectQuestEnderKey(id: 10, quest: 20);
      viewModel.idController.init(11);
      viewModel.questController.init(21);
      repository.failUpdates = true;

      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, oldKey);
      repository.failUpdates = false;
      await viewModel.persist();

      expect(repository.updateKeys, [oldKey, oldKey]);
      expect(repository.rows.single.toJson(), {'id': 11, 'quest': 21});
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });
  });

  test('开始与结束关系 UI、Entity、Repository 遵守迁移边界', () {
    const domains = ['starter', 'ender'];
    for (final domain in domains) {
      final entity = File(
        'lib/entity/game_object_quest_${domain}_entity.dart',
      ).readAsStringSync();
      final repository = File(
        'lib/repository/game_object_quest_${domain}_repository.dart',
      ).readAsStringSync();
      final viewModel = File(
        'lib/page/quest/game_object_quest_${domain}_collection_editor_view_model.dart',
      ).readAsStringSync();
      final view = File(
        'lib/page/quest/game_object_quest_${domain}_view.dart',
      ).readAsStringSync();

      expect(
        entity,
        isNot(contains('final String localeName;')),
        reason: '$domain 的 JOIN 投影不能成为 Full Entity 字段',
      );
      expect(
        repository,
        isNot(contains('saveGameObjectQuest')),
        reason: domain,
      );
      expect(viewModel, contains('final editingKey = signal<'), reason: domain);
      expect(viewModel, contains('selectedKey.value = key'), reason: domain);
      expect(view, isNot(contains('readOnly:')), reason: domain);
      expect(view, contains('FoxyPagination('), reason: domain);
    }
  });
}

class _FakeStarterRepository extends GameObjectQuestStarterRepository {
  final List<GameObjectQuestStarterEntity> rows;
  bool failUpdates = false;
  final updateKeys = <GameObjectQuestStarterKey>[];

  _FakeStarterRepository(this.rows);

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
  ) async {
    for (final row in rows) {
      if (GameObjectQuestStarterKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> updateGameObjectQuestStarter(
    GameObjectQuestStarterKey originalKey,
    GameObjectQuestStarterEntity model,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => GameObjectQuestStarterKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = model;
  }
}

class _FakeEnderRepository extends GameObjectQuestEnderRepository {
  final List<GameObjectQuestEnderEntity> rows;
  bool failUpdates = false;
  final updateKeys = <GameObjectQuestEnderKey>[];

  _FakeEnderRepository(this.rows);

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
  ) async {
    for (final row in rows) {
      if (GameObjectQuestEnderKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> updateGameObjectQuestEnder(
    GameObjectQuestEnderKey originalKey,
    GameObjectQuestEnderEntity model,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => GameObjectQuestEnderKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = model;
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

class _TestStarterRepository extends GameObjectQuestStarterRepository {
  @override
  final Laconic laconic;

  _TestStarterRepository(this.laconic);
}

class _TestEnderRepository extends GameObjectQuestEnderRepository {
  @override
  final Laconic laconic;

  _TestEnderRepository(this.laconic);
}
