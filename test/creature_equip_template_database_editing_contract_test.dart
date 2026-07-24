import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/creature_equip_template_entity.dart';
import 'package:foxy/page/creature_template/creature_equip_template_collection_editor_view_model.dart';
import 'package:foxy/repository/creature_equip_template_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';
import './support/local_dart_library_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('CreatureEquipTemplateKey 和 Brief 完整覆盖两列主键', () {
    const entity = CreatureEquipTemplateEntity(creatureID: 10, id: 2);
    final key = CreatureEquipTemplateKey.fromEntity(entity);
    final same = CreatureEquipTemplateKey.fromEntity(
      entity.copyWith(itemID1: 123),
    );
    const brief = BriefCreatureEquipTemplateEntity(creatureID: 10, id: 2);

    expect(key, same);
    expect(key.hashCode, same.hashCode);
    expect(
      key,
      isNot(CreatureEquipTemplateKey.fromEntity(entity.copyWith(id: 3))),
    );
    expect(brief.key, key);
  });

  group('CreatureEquipTemplateRepository write contract', () {
    test('UPDATE 使用完整旧 key 定位并写入 candidate 六列', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestCreatureEquipTemplateRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );
      const oldKey = CreatureEquipTemplateKey(creatureID: 10, id: 2);
      const candidate = CreatureEquipTemplateEntity(
        creatureID: 11,
        id: 3,
        itemID1: 101,
        itemID2: 102,
        itemID3: 103,
        verifiedBuild: 12340,
      );

      await repository.updateCreatureEquipTemplate(oldKey, candidate);

      expect(queries.single.bindings, [
        ...candidate.toJson().values,
        oldKey.creatureID,
        oldKey.id,
      ]);
    });

    test('UPDATE 与 DELETE 零行结果报告旧记录不存在', () async {
      final repository = _TestCreatureEquipTemplateRepository(
        Laconic(_RecordingDriver(affectedRows: 0)),
      );
      const key = CreatureEquipTemplateKey(creatureID: 10, id: 2);
      await expectLater(
        repository.updateCreatureEquipTemplate(
          key,
          const CreatureEquipTemplateEntity(),
        ),
        throwsA(isA<StateError>()),
      );
      await expectLater(
        repository.destroyCreatureEquipTemplate(key),
        throwsA(isA<StateError>()),
      );
    });

    test('Brief 查询显式选择三个物品槽并分页', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestCreatureEquipTemplateRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );
      await repository.getBriefCreatureEquipTemplates(10, page: 2);
      expect(queries.single.sql, isNot(contains('cet.*')));
      expect(queries.single.sql, contains('cet.ItemID1'));
      expect(queries.single.sql, contains('cet.ItemID2'));
      expect(queries.single.sql, contains('cet.ItemID3'));
      expect(
        queries.single.bindings.sublist(queries.single.bindings.length - 2),
        [50, 50],
      );
    });
  });

  group('CreatureEquipTemplate inline identity', () {
    late _FakeCreatureEquipTemplateRepository repository;

    setUp(() {
      repository = _FakeCreatureEquipTemplateRepository([
        const CreatureEquipTemplateEntity(creatureID: 10, id: 2, itemID1: 101),
      ]);
      GetIt.instance.registerSingleton<CreatureEquipTemplateRepository>(
        repository,
      );
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());
    });

    tearDown(() async => GetIt.instance.reset());

    test('键变化用旧 key 更新，失败时保留旧 key 供重试', () async {
      final viewModel = CreatureEquipTemplateCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 10);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      const oldKey = CreatureEquipTemplateKey(creatureID: 10, id: 2);
      repository.failUpdates = true;
      viewModel.creatureIdController.init(11);
      viewModel.idController.init(3);

      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, oldKey);

      repository.failUpdates = false;
      await viewModel.persist();
      expect(repository.updateKeys, [oldKey, oldKey]);
      expect(repository.rows.single.creatureID, 11);
      expect(repository.rows.single.id, 3);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });

    test('父范围变化和新建清空 editingKey 并使用显式预分配 ID', () async {
      final viewModel = CreatureEquipTemplateCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 10);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);

      await viewModel.setParentKey(12);
      expect(viewModel.editingKey.value, isNull);
      await viewModel.create();
      expect(viewModel.idController.collect(), 1);
      expect(viewModel.editingKey.value, isNull);
      await viewModel.persist();
      expect(repository.storeCount, 1);
    });
  });

  test('UI 与 Repository 遵守完整字段和 row identity 合同', () {
    final repository = readLocalDartLibrarySource(
      'lib/repository/creature_equip_template_repository.dart',
    );
    final viewModel = File(
      'lib/page/creature_template/creature_equip_template_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/creature_template/creature_equip_template_view.dart',
    ).readAsStringSync();

    expect(repository, isNot(contains('saveCreatureEquipTemplate')));
    expect(
      viewModel,
      contains('final editingKey = signal<CreatureEquipTemplateKey?>(null)'),
    );
    expect(viewModel, contains('itemID1Controller.collect()'));
    expect(viewModel, contains('itemID2Controller.collect()'));
    expect(viewModel, contains('itemID3Controller.collect()'));
    expect(view, isNot(contains('readOnly: true')));
    expect(view, contains('FoxyPagination('));
  });
}

class _FakeCreatureEquipTemplateRepository
    extends CreatureEquipTemplateRepository {
  final List<CreatureEquipTemplateEntity> rows;
  bool failUpdates = false;
  int storeCount = 0;
  final updateKeys = <CreatureEquipTemplateKey>[];

  _FakeCreatureEquipTemplateRepository(this.rows);

  @override
  Future<int> countCreatureEquipTemplates(int creatureID) async =>
      rows.where((row) => row.creatureID == creatureID).length;

  @override
  Future<CreatureEquipTemplateEntity> createCreatureEquipTemplate(
    int creatureID,
  ) async {
    final ids = rows
        .where((row) => row.creatureID == creatureID)
        .map((row) => row.id);
    final id = ids.isEmpty ? 1 : ids.reduce((a, b) => a > b ? a : b) + 1;
    return CreatureEquipTemplateEntity(creatureID: creatureID, id: id);
  }

  @override
  Future<List<BriefCreatureEquipTemplateEntity>> getBriefCreatureEquipTemplates(
    int creatureID, {
    int page = 1,
  }) async => rows
      .where((row) => row.creatureID == creatureID)
      .map(
        (row) => BriefCreatureEquipTemplateEntity(
          creatureID: row.creatureID,
          id: row.id,
          itemID1: row.itemID1,
          itemID2: row.itemID2,
          itemID3: row.itemID3,
          verifiedBuild: row.verifiedBuild,
        ),
      )
      .toList();

  @override
  Future<CreatureEquipTemplateEntity?> getCreatureEquipTemplate(
    CreatureEquipTemplateKey key,
  ) async {
    for (final row in rows) {
      if (CreatureEquipTemplateKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> storeCreatureEquipTemplate(
    CreatureEquipTemplateEntity equip,
  ) async {
    storeCount++;
    rows.add(equip);
  }

  @override
  Future<void> updateCreatureEquipTemplate(
    CreatureEquipTemplateKey originalKey,
    CreatureEquipTemplateEntity equip,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => CreatureEquipTemplateKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = equip;
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

class _TestCreatureEquipTemplateRepository
    extends CreatureEquipTemplateRepository {
  @override
  final Laconic laconic;
  _TestCreatureEquipTemplateRepository(this.laconic);
}
