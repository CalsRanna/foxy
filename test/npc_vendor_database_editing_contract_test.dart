import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/npc_vendor_entity.dart';
import 'package:foxy/page/creature_template/npc_vendor_collection_editor_view_model.dart';
import 'package:foxy/repository/npc_vendor_repository.dart';
import 'package:foxy/router/router_facade.dart';
import 'package:foxy/widget/form/validation/npc_vendor_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

import 'support/local_dart_library_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NpcVendorKey 与 Brief Entity', () {
    test('完整覆盖 entry、item、ExtendedCost 并实现值相等', () {
      const vendor = NpcVendorEntity(entry: 10, item: 20, extendedCost: 30);
      final key = NpcVendorKey.fromEntity(vendor);
      final same = NpcVendorKey.fromEntity(vendor.copyWith(slot: 2));

      expect(key, same);
      expect(key.hashCode, same.hashCode);
      expect(key, isNot(NpcVendorKey.fromEntity(vendor.copyWith(entry: 11))));
      expect(key, isNot(NpcVendorKey.fromEntity(vendor.copyWith(item: 21))));
      expect(
        key,
        isNot(NpcVendorKey.fromEntity(vendor.copyWith(extendedCost: 31))),
      );
    });

    test('Brief Entity 只保留展示列和完整 key', () {
      const brief = BriefNpcVendorEntity(
        entry: 10,
        slot: 1,
        item: 20,
        maxcount: 3,
        incrtime: 4,
        extendedCost: 30,
      );

      expect(
        brief.key,
        const NpcVendorKey(entry: 10, item: 20, extendedCost: 30),
      );
      final library = readLocalDartLibrarySource(
        'lib/entity/npc_vendor_entity.dart',
      );
      final source = library.substring(
        library.indexOf('final class BriefNpcVendorEntity'),
      );
      expect(source, isNot(contains('verifiedBuild')));
    });
  });

  group('NpcVendorRepository write contract', () {
    test('UPDATE 使用完整旧 key 定位并写入 candidate 全部七列', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestNpcVendorRepository(
        Laconic(_RecordingDriver(affectedRows: 1), listen: queries.add),
      );
      const originalKey = NpcVendorKey(entry: 10, item: 20, extendedCost: 30);
      const candidate = NpcVendorEntity(
        entry: 11,
        slot: 2,
        item: 21,
        maxcount: 5,
        incrtime: 60,
        extendedCost: 31,
        verifiedBuild: 12340,
      );

      await repository.updateNpcVendor(originalKey, candidate);

      expect(queries, hasLength(1));
      expect(queries.single.sql.toLowerCase(), startsWith('update'));
      expect(queries.single.bindings, [
        ...candidate.toJson().values,
        originalKey.entry,
        originalKey.item,
        originalKey.extendedCost,
      ]);
    });

    test('UPDATE 与 DELETE 零行结果报告旧记录不存在', () async {
      final repository = _TestNpcVendorRepository(
        Laconic(_RecordingDriver(affectedRows: 0)),
      );
      const key = NpcVendorKey(entry: 10, item: 20, extendedCost: 30);

      await expectLater(
        repository.updateNpcVendor(key, const NpcVendorEntity()),
        throwsA(isA<StateError>()),
      );
      await expectLater(
        repository.destroyNpcVendor(key),
        throwsA(isA<StateError>()),
      );
    });

    test('Brief 查询显式选择字段并分页，不读取完整行', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestNpcVendorRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );

      await repository.getBriefNpcVendors(10, page: 2);

      final sql = queries.single.sql;
      expect(sql, isNot(contains('nv.*')));
      expect(sql, isNot(contains('VerifiedBuild')));
      expect(sql.toLowerCase(), contains('limit ? offset ?'));
      expect(queries.single.bindings.sublist(2), [50, 50]);
    });
  });

  group('NpcVendor inline editing identity', () {
    late _FakeNpcVendorRepository repository;

    setUp(() {
      repository = _FakeNpcVendorRepository([
        const NpcVendorEntity(entry: 10, slot: 0, item: 20, extendedCost: 30),
      ]);
      GetIt.instance.registerSingleton<NpcVendorRepository>(repository);
      GetIt.instance.registerSingleton<RouterFacade>(RouterFacade());
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });

    test('选中 Brief 后使用旧 key 更新，多列键变化后清空范围状态', () async {
      final viewModel = NpcVendorCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 10);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      const originalKey = NpcVendorKey(entry: 10, item: 20, extendedCost: 30);
      expect(viewModel.editingKey.value, originalKey);

      viewModel.creatureIdController.init(11);
      viewModel.itemController.init(21);
      viewModel.extendedCostController.init(31);
      viewModel.maxcountController.init(5);
      viewModel.incrtimeController.init(60);
      await viewModel.persist();

      expect(repository.updateKeys, [originalKey]);
      expect(repository.rows.single.entry, 11);
      expect(repository.rows.single.item, 21);
      expect(repository.rows.single.extendedCost, 31);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.selectedKey.value, isNull);
      expect(viewModel.editingKey.value, isNull);
    });

    test('保存失败保留 editingKey，修正后仍可按旧 key 重试', () async {
      final viewModel = NpcVendorCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 10);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      final originalKey = viewModel.editingKey.value;
      repository.failUpdates = true;
      viewModel.itemController.init(21);

      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, originalKey);

      repository.failUpdates = false;
      await viewModel.persist();
      expect(repository.updateKeys, [originalKey, originalKey]);
    });

    test('新建和父范围切换都会清空子行身份', () async {
      final viewModel = NpcVendorCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.initSignals(parentKey: 10);
      viewModel.selectedKey.value = viewModel.items.value[0].key;
      await viewModel.edit(viewModel.selectedKey.value!);
      expect(viewModel.editingKey.value, isNotNull);

      await viewModel.setParentKey(12);
      expect(viewModel.parentKey.value, 12);
      expect(viewModel.creatureIdController.collect(), 12);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.selectedKey.value, isNull);

      await viewModel.create();
      expect(viewModel.editingKey.value, isNull);
      viewModel.itemController.init(50);
      await viewModel.persist();
      expect(repository.storeCount, 1);
    });
  });

  test('字段校验从 Repository 移到 ViewModel validation mixin', () {
    final validation = _NpcVendorValidation();
    expect(
      () => validation.validateNpcVendorFields(
        const NpcVendorEntity(entry: 1, item: 2, maxcount: 1, incrtime: 0),
      ),
      throwsA(isA<StateError>()),
    );
    final repository = File(
      'lib/repository/npc_vendor_repository.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/creature_template/npc_vendor_view.dart',
    ).readAsStringSync();
    final viewModel = File(
      'lib/page/creature_template/npc_vendor_collection_editor_view_model.dart',
    ).readAsStringSync();
    expect(repository, isNot(contains('saveNpcVendor')));
    expect(repository, isNot(contains("json.remove('entry')")));
    expect(viewModel, contains('final editingKey = signal<NpcVendorKey?>'));
    expect(viewModel, isNot(contains('_editingItem')));
    expect(viewModel, contains('Future<void> destroy('));
    expect(view, isNot(contains('readOnly: isEditing')));
    expect(view, contains('FoxyPagination('));
  });
}

class _FakeNpcVendorRepository extends NpcVendorRepository {
  final List<NpcVendorEntity> rows;
  bool failUpdates = false;
  int storeCount = 0;
  final updateKeys = <NpcVendorKey>[];

  _FakeNpcVendorRepository(this.rows);

  @override
  Future<int> countNpcVendors(int entry) async {
    return rows.where((row) => row.entry == entry).length;
  }

  @override
  Future<NpcVendorEntity> createNpcVendor(int entry) async {
    final slots = rows
        .where((row) => row.entry == entry)
        .map((row) => row.slot);
    final nextSlot = slots.isEmpty
        ? 0
        : slots.reduce((a, b) => a > b ? a : b) + 1;
    return NpcVendorEntity(entry: entry, slot: nextSlot);
  }

  @override
  Future<List<BriefNpcVendorEntity>> getBriefNpcVendors(
    int entry, {
    int page = 1,
  }) async {
    return rows
        .where((row) => row.entry == entry)
        .map(
          (row) => BriefNpcVendorEntity(
            entry: row.entry,
            slot: row.slot,
            item: row.item,
            maxcount: row.maxcount,
            incrtime: row.incrtime,
            extendedCost: row.extendedCost,
          ),
        )
        .toList();
  }

  @override
  Future<NpcVendorEntity?> getNpcVendor(NpcVendorKey key) async {
    for (final row in rows) {
      if (NpcVendorKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> storeNpcVendor(NpcVendorEntity vendor) async {
    storeCount++;
    rows.add(vendor);
  }

  @override
  Future<void> updateNpcVendor(
    NpcVendorKey originalKey,
    NpcVendorEntity vendor,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('write failed');
    final index = rows.indexWhere(
      (row) => NpcVendorKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = vendor;
  }
}

class _NpcVendorValidation
    with ViewModelValidationMixin, NpcVendorValidationMixin {}

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

class _TestNpcVendorRepository extends NpcVendorRepository {
  @override
  final Laconic laconic;

  _TestNpcVendorRepository(this.laconic);
}
