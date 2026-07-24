import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/spell_loot_template_entity.dart';
import 'package:foxy/page/spell/spell_loot_template_collection_editor_view_model.dart';
import 'package:foxy/repository/spell_loot_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('SpellLootTemplateKey 和 Brief 完整覆盖两列主键', () {
    const entity = SpellLootTemplateEntity(entry: 10, item: 20);
    final key = SpellLootTemplateKey.fromEntity(entity);
    final same = SpellLootTemplateKey.fromEntity(
      entity.copyWith(reference: 30, groupId: 40),
    );
    const brief = BriefSpellLootTemplateEntity(entry: 10, item: 20);

    expect(key, same);
    expect(key.hashCode, same.hashCode);
    expect(
      key,
      isNot(SpellLootTemplateKey.fromEntity(entity.copyWith(entry: 11))),
    );
    expect(
      key,
      isNot(SpellLootTemplateKey.fromEntity(entity.copyWith(item: 21))),
    );
    expect(brief.key, key);
  });

  test('UPDATE 使用完整旧 key 定位并写入 candidate 十列', () async {
    final queries = <LaconicQuery>[];
    final repository = _TestRepository(
      Laconic(_RecordingDriver(), listen: queries.add),
    );
    const oldKey = SpellLootTemplateKey(entry: 10, item: 20);
    const candidate = SpellLootTemplateEntity(
      entry: 11,
      item: 21,
      reference: 22,
      chance: 23,
      questRequired: 1,
      lootMode: 2,
      groupId: 24,
      minCount: 25,
      maxCount: 26,
      comment: 'candidate',
    );

    await repository.updateSpellLootTemplate(oldKey, candidate);

    expect(queries.single.bindings, [
      ...candidate.toJson().values,
      oldKey.entry,
      oldKey.item,
    ]);
  });

  test('UPDATE、DELETE 零行报错且 Brief 查询稳定分页', () async {
    final missingRepository = _TestRepository(
      Laconic(_RecordingDriver(affectedRows: 0)),
    );
    const key = SpellLootTemplateKey(entry: 10, item: 20);
    await expectLater(
      missingRepository.updateSpellLootTemplate(
        key,
        const SpellLootTemplateEntity(),
      ),
      throwsA(isA<StateError>()),
    );
    await expectLater(
      missingRepository.destroySpellLootTemplate(key),
      throwsA(isA<StateError>()),
    );

    final queries = <LaconicQuery>[];
    final repository = _TestRepository(
      Laconic(_RecordingDriver(), listen: queries.add),
    );
    await repository.getBriefSpellLootTemplates(10, page: 2);
    expect(queries.single.sql, isNot(contains('slt.*')));
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
        const SpellLootTemplateEntity(entry: 10, item: 20),
      ]);
      GetIt.instance.registerSingleton<SpellLootTemplateRepository>(repository);
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());
    });

    tearDown(() async => GetIt.instance.reset());

    test('修改两列 key 仍按旧 key 更新，失败时保留并可重试', () async {
      final viewModel = SpellLootTemplateCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 10);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      const oldKey = SpellLootTemplateKey(entry: 10, item: 20);
      expect(viewModel.editingKey.value, oldKey);
      viewModel.spellIdController.init(11);
      viewModel.itemController.init(21);
      repository.failUpdates = true;

      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, oldKey);

      repository.failUpdates = false;
      await viewModel.persist();
      expect(repository.updateKeys, [oldKey, oldKey]);
      expect(repository.rows.single.entry, 11);
      expect(repository.rows.single.item, 21);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });

    test('切换父范围和新建都会清空旧行身份', () async {
      final viewModel = SpellLootTemplateCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 10);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);

      await viewModel.setParentKey(12);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.selectedKey.value, isNull);
      await viewModel.create();
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.spellIdController.collect(), 12);
    });
  });

  test('UI、Full Entity 和 ViewModel 遵守迁移边界', () {
    final entity = File(
      'lib/entity/spell_loot_template_entity.dart',
    ).readAsStringSync();
    final repository = File(
      'lib/repository/spell_loot_template_repository.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/spell/spell_loot_template_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/spell/spell_loot_template_view.dart',
    ).readAsStringSync();

    expect(entity, isNot(contains('final String itemName;')));
    expect(entity, isNot(contains('this.itemName')));
    expect(repository, isNot(contains('saveSpellLootTemplate')));
    expect(
      viewModel,
      contains('final editingKey = signal<SpellLootTemplateKey?>(null)'),
    );
    expect(viewModel, contains('destroySpellLootTemplate(key)'));
    expect(view, isNot(contains('readOnly:')));
    expect(view, contains('FoxyPagination('));
  });
}

class _FakeRepository extends SpellLootTemplateRepository {
  final List<SpellLootTemplateEntity> rows;
  bool failUpdates = false;
  final updateKeys = <SpellLootTemplateKey>[];

  _FakeRepository(this.rows);

  @override
  Future<int> countSpellLootTemplates(int entry) async {
    return rows.where((row) => row.entry == entry).length;
  }

  @override
  Future<SpellLootTemplateEntity> createSpellLootTemplate(int entry) async {
    return SpellLootTemplateEntity(entry: entry);
  }

  @override
  Future<List<BriefSpellLootTemplateEntity>> getBriefSpellLootTemplates(
    int entry, {
    int page = 1,
  }) async {
    return rows
        .where((row) => row.entry == entry)
        .map(
          (row) => BriefSpellLootTemplateEntity(
            entry: row.entry,
            item: row.item,
            reference: row.reference,
            chance: row.chance,
            questRequired: row.questRequired,
            lootMode: row.lootMode,
            groupId: row.groupId,
            minCount: row.minCount,
            maxCount: row.maxCount,
            comment: row.comment,
          ),
        )
        .toList();
  }

  @override
  Future<SpellLootTemplateEntity?> getSpellLootTemplate(
    SpellLootTemplateKey key,
  ) async {
    for (final row in rows) {
      if (SpellLootTemplateKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> updateSpellLootTemplate(
    SpellLootTemplateKey originalKey,
    SpellLootTemplateEntity data,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => SpellLootTemplateKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = data;
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

class _TestRepository extends SpellLootTemplateRepository {
  @override
  final Laconic laconic;

  _TestRepository(this.laconic);
}
