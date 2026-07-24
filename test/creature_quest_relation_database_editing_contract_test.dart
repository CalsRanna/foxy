import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/brief_creature_quest_ender_entity.dart';
import 'package:foxy/entity/brief_creature_quest_starter_entity.dart';
import 'package:foxy/entity/creature_quest_ender_entity.dart';
import 'package:foxy/entity/creature_quest_starter_entity.dart';
import 'package:foxy/page/quest/creature_quest_ender_collection_editor_view_model.dart';
import 'package:foxy/page/quest/creature_quest_starter_collection_editor_view_model.dart';
import 'package:foxy/repository/creature_quest_ender_repository.dart';
import 'package:foxy/repository/creature_quest_starter_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('生物任务开始/结束 Key 与 Brief 覆盖 id + quest', () {
    const starter = CreatureQuestStarterEntity(id: 10, quest: 20);
    const ender = CreatureQuestEnderEntity(id: 10, quest: 20);
    final starterKey = CreatureQuestStarterKey.fromEntity(starter);
    final enderKey = CreatureQuestEnderKey.fromEntity(ender);

    expect(starterKey, CreatureQuestStarterKey.fromEntity(starter.copyWith()));
    expect(
      starterKey,
      isNot(CreatureQuestStarterKey.fromEntity(starter.copyWith(quest: 21))),
    );
    expect(
      const BriefCreatureQuestStarterEntity(id: 10, quest: 20).key,
      starterKey,
    );
    expect(enderKey, CreatureQuestEnderKey.fromEntity(ender.copyWith()));
    expect(
      enderKey,
      isNot(CreatureQuestEnderKey.fromEntity(ender.copyWith(id: 11))),
    );
    expect(
      const BriefCreatureQuestEnderEntity(id: 10, quest: 20).key,
      enderKey,
    );
  });

  test('两张表 UPDATE 使用旧 key 并写入完整 candidate', () async {
    final starterQueries = <LaconicQuery>[];
    final starterRepository = _TestStarterRepository(
      Laconic(_RecordingDriver(), listen: starterQueries.add),
    );
    await starterRepository.updateCreatureQuestStarter(
      const CreatureQuestStarterKey(id: 10, quest: 20),
      const CreatureQuestStarterEntity(id: 11, quest: 21),
    );
    expect(starterQueries.single.bindings, [11, 21, 10, 20]);

    final enderQueries = <LaconicQuery>[];
    final enderRepository = _TestEnderRepository(
      Laconic(_RecordingDriver(), listen: enderQueries.add),
    );
    await enderRepository.updateCreatureQuestEnder(
      const CreatureQuestEnderKey(id: 30, quest: 40),
      const CreatureQuestEnderEntity(id: 31, quest: 41),
    );
    expect(enderQueries.single.bindings, [31, 41, 30, 40]);
  });

  test('两张表零行写入报错，Brief 查询稳定分页', () async {
    final starterMissing = _TestStarterRepository(
      Laconic(_RecordingDriver(affectedRows: 0)),
    );
    const starterKey = CreatureQuestStarterKey(id: 10, quest: 20);
    await expectLater(
      starterMissing.updateCreatureQuestStarter(
        starterKey,
        const CreatureQuestStarterEntity(),
      ),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      starterMissing.destroyCreatureQuestStarter(starterKey),
      throwsA(isA<StateError>()),
    );

    final enderMissing = _TestEnderRepository(
      Laconic(_RecordingDriver(affectedRows: 0)),
    );
    const enderKey = CreatureQuestEnderKey(id: 10, quest: 20);
    await expectLater(
      enderMissing.updateCreatureQuestEnder(
        enderKey,
        const CreatureQuestEnderEntity(),
      ),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      enderMissing.destroyCreatureQuestEnder(enderKey),
      throwsA(isA<StateError>()),
    );

    final queries = <LaconicQuery>[];
    final repository = _TestStarterRepository(
      Laconic(_RecordingDriver(), listen: queries.add),
    );
    await repository.getBriefCreatureQuestStarters(20, page: 2);
    expect(queries.single.sql.toLowerCase(), contains('order by'));
    expect(
      queries.single.bindings.sublist(queries.single.bindings.length - 2),
      [50, 50],
    );
  });

  group('inline editing identity', () {
    tearDown(() async => GetIt.instance.reset());

    test('开始关系更新失败保留旧 key 并可重试', () async {
      final repository = _FakeStarterRepository([
        const CreatureQuestStarterEntity(id: 10, quest: 20),
      ]);
      GetIt.instance.registerSingleton<CreatureQuestStarterRepository>(
        repository,
      );
      final viewModel = CreatureQuestStarterCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 20);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      const oldKey = CreatureQuestStarterKey(id: 10, quest: 20);
      viewModel.idController.init(11);
      viewModel.questController.init(21);
      repository.failUpdates = true;
      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, oldKey);
      repository.failUpdates = false;
      await viewModel.persist();
      expect(repository.updateKeys, [oldKey, oldKey]);
      expect(repository.rows.single.toJson(), {'id': 11, 'quest': 21});
      expect(viewModel.editingKey.value, isNull);
    });

    test('结束关系更新失败保留旧 key 并可重试', () async {
      final repository = _FakeEnderRepository([
        const CreatureQuestEnderEntity(id: 10, quest: 20),
      ]);
      GetIt.instance.registerSingleton<CreatureQuestEnderRepository>(
        repository,
      );
      final viewModel = CreatureQuestEnderCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 20);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      const oldKey = CreatureQuestEnderKey(id: 10, quest: 20);
      viewModel.idController.init(11);
      viewModel.questController.init(21);
      repository.failUpdates = true;
      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, oldKey);
      repository.failUpdates = false;
      await viewModel.persist();
      expect(repository.updateKeys, [oldKey, oldKey]);
      expect(repository.rows.single.toJson(), {'id': 11, 'quest': 21});
      expect(viewModel.editingKey.value, isNull);
    });
  });

  test('UI、Full Entity 与 Repository 遵守迁移边界', () {
    for (final domain in ['starter', 'ender']) {
      final entity = File(
        'lib/entity/creature_quest_${domain}_entity.dart',
      ).readAsStringSync();
      final repository = File(
        'lib/repository/creature_quest_${domain}_repository.dart',
      ).readAsStringSync();
      final viewModel = File(
        'lib/page/quest/creature_quest_${domain}_collection_editor_view_model.dart',
      ).readAsStringSync();
      final view = File(
        'lib/page/quest/creature_quest_${domain}_view.dart',
      ).readAsStringSync();
      expect(entity, isNot(contains('localeName')), reason: domain);
      expect(repository, isNot(contains('saveCreatureQuest')), reason: domain);
      expect(viewModel, contains('final editingKey = signal<'), reason: domain);
      expect(view, isNot(contains('readOnly:')), reason: domain);
      expect(view, contains('FoxyPagination('), reason: domain);
    }
  });
}

class _FakeStarterRepository extends CreatureQuestStarterRepository {
  final List<CreatureQuestStarterEntity> rows;
  bool failUpdates = false;
  final updateKeys = <CreatureQuestStarterKey>[];
  _FakeStarterRepository(this.rows);

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
  ) async {
    for (final row in rows) {
      if (CreatureQuestStarterKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> updateCreatureQuestStarter(
    CreatureQuestStarterKey originalKey,
    CreatureQuestStarterEntity model,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => CreatureQuestStarterKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = model;
  }
}

class _FakeEnderRepository extends CreatureQuestEnderRepository {
  final List<CreatureQuestEnderEntity> rows;
  bool failUpdates = false;
  final updateKeys = <CreatureQuestEnderKey>[];
  _FakeEnderRepository(this.rows);

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
  ) async {
    for (final row in rows) {
      if (CreatureQuestEnderKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> updateCreatureQuestEnder(
    CreatureQuestEnderKey originalKey,
    CreatureQuestEnderEntity model,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => CreatureQuestEnderKey.fromEntity(row) == originalKey,
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

class _TestStarterRepository extends CreatureQuestStarterRepository {
  @override
  final Laconic laconic;
  _TestStarterRepository(this.laconic);
}

class _TestEnderRepository extends CreatureQuestEnderRepository {
  @override
  final Laconic laconic;
  _TestEnderRepository(this.laconic);
}
