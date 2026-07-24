import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/page/gossip_menu/gossip_menu_option_collection_editor_view_model.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gossip_menu_option_locale_repository.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';
import 'package:foxy/use_case/gossip_menu/copy_gossip_menu_option_use_case.dart';
import 'package:foxy/use_case/gossip_menu/destroy_gossip_menu_option_use_case.dart';
import 'package:foxy/use_case/gossip_menu/save_gossip_menu_option_use_case.dart';
import 'package:foxy/widget/form/validation/gossip_menu_option_entity_validation_mixin.dart';
import 'package:foxy/widget/form/view_model_validation_mixin.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

import 'support/local_dart_library_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GossipMenuOption typed row identity', () {
    test('base 和 locale key 覆盖全部复合主键列并实现值相等', () {
      const option = GossipMenuOptionEntity(menuId: 10, optionId: 2);
      const locale = GossipMenuOptionLocaleEntity(
        menuId: 10,
        optionId: 2,
        locale: 'zhCN',
      );

      expect(
        GossipMenuOptionKey.fromEntity(option),
        const GossipMenuOptionKey(menuId: 10, optionId: 2),
      );
      expect(
        GossipMenuOptionLocaleKey.fromEntity(locale),
        const GossipMenuOptionLocaleKey(
          menuId: 10,
          optionId: 2,
          locale: 'zhCN',
        ),
      );
      expect(
        GossipMenuOptionLocaleKey.fromEntity(locale).hashCode,
        const GossipMenuOptionLocaleKey(
          menuId: 10,
          optionId: 2,
          locale: 'zhCN',
        ).hashCode,
      );
      expect(
        GossipMenuOptionLocaleKey.fromEntity(locale),
        isNot(
          GossipMenuOptionLocaleKey.fromEntity(locale.copyWith(locale: 'deDE')),
        ),
      );
    });

    test('Brief Entity 暴露完整 typed key，且不携带未展示物理列', () {
      const option = BriefGossipMenuOptionEntity(menuId: 10, optionId: 2);
      const locale = BriefGossipMenuOptionLocaleEntity(
        menuId: 10,
        optionId: 2,
        locale: 'zhCN',
      );

      expect(option.key, const GossipMenuOptionKey(menuId: 10, optionId: 2));
      expect(
        locale.key,
        const GossipMenuOptionLocaleKey(
          menuId: 10,
          optionId: 2,
          locale: 'zhCN',
        ),
      );
      final optionLibrarySource = readLocalDartLibrarySource(
        'lib/entity/gossip_menu_option_entity.dart',
      );
      final optionSource = optionLibrarySource.substring(
        optionLibrarySource.indexOf('final class BriefGossipMenuOptionEntity'),
      );
      final localeLibrarySource = readLocalDartLibrarySource(
        'lib/entity/gossip_menu_option_locale_entity.dart',
      );
      final localeSource = localeLibrarySource.substring(
        localeLibrarySource.indexOf(
          'final class BriefGossipMenuOptionLocaleEntity',
        ),
      );
      expect(optionSource, isNot(contains('verifiedBuild')));
      expect(localeSource, isNot(contains('boxText')));
    });
  });

  group('GossipMenuOption repositories write contract', () {
    test('base UPDATE 用旧 key 定位并写入 candidate 全部十四列', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestGossipMenuOptionRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );
      const originalKey = GossipMenuOptionKey(menuId: 10, optionId: 2);
      const candidate = GossipMenuOptionEntity(
        menuId: 11,
        optionId: 3,
        optionIcon: 1,
        optionText: 'text',
        optionBroadcastTextId: 4,
        optionType: 5,
        optionNpcFlag: 6,
        boxCoded: 1,
        boxMoney: 7,
        boxText: 'box',
        boxBroadcastTextId: 8,
        actionMenuId: 9,
        actionPoiId: 10,
        verifiedBuild: 12340,
      );

      await repository.updateGossipMenuOption(originalKey, candidate);

      expect(queries, hasLength(1));
      expect(queries.single.bindings, [
        ...candidate.toJson().values,
        originalKey.menuId,
        originalKey.optionId,
      ]);
    });

    test('locale UPDATE 用旧三列 key 定位并写入 candidate 全部五列', () async {
      final queries = <LaconicQuery>[];
      final repository = _TestGossipMenuOptionLocaleRepository(
        Laconic(_RecordingDriver(), listen: queries.add),
      );
      const originalKey = GossipMenuOptionLocaleKey(
        menuId: 10,
        optionId: 2,
        locale: 'zhCN',
      );
      const candidate = GossipMenuOptionLocaleEntity(
        menuId: 11,
        optionId: 3,
        locale: 'zhCN',
        optionText: '文本',
        boxText: '确认',
      );

      await repository.updateGossipMenuOptionLocale(originalKey, candidate);

      expect(queries, hasLength(1));
      expect(queries.single.bindings, [
        ...candidate.toJson().values,
        originalKey.menuId,
        originalKey.optionId,
        originalKey.locale,
      ]);
    });

    test('base 与 locale 单行 UPDATE/DELETE 的零行结果会报错', () async {
      final laconic = Laconic(_RecordingDriver(affectedRows: 0));
      final baseRepository = _TestGossipMenuOptionRepository(laconic);
      final localeRepository = _TestGossipMenuOptionLocaleRepository(laconic);
      const baseKey = GossipMenuOptionKey(menuId: 10, optionId: 2);
      const localeKey = GossipMenuOptionLocaleKey(
        menuId: 10,
        optionId: 2,
        locale: 'zhCN',
      );

      await expectLater(
        baseRepository.updateGossipMenuOption(
          baseKey,
          const GossipMenuOptionEntity(),
        ),
        throwsA(isA<StateError>()),
      );
      await expectLater(
        baseRepository.destroyGossipMenuOption(baseKey),
        throwsA(isA<StateError>()),
      );
      await expectLater(
        localeRepository.updateGossipMenuOptionLocale(
          localeKey,
          const GossipMenuOptionLocaleEntity(),
        ),
        throwsA(isA<StateError>()),
      );
      await expectLater(
        localeRepository.destroyGossipMenuOptionLocale(localeKey),
        throwsA(isA<StateError>()),
      );
    });

    test('base 与 locale Brief 查询显式选择字段、稳定排序并分页', () async {
      final baseQueries = <LaconicQuery>[];
      final localeQueries = <LaconicQuery>[];
      final baseRepository = _TestGossipMenuOptionRepository(
        Laconic(_RecordingDriver(), listen: baseQueries.add),
      );
      final localeRepository = _TestGossipMenuOptionLocaleRepository(
        Laconic(_RecordingDriver(), listen: localeQueries.add),
      );

      await baseRepository.getBriefGossipMenuOptions(10, page: 2);
      await localeRepository.getBriefGossipMenuOptionLocales(page: 2);

      expect(baseQueries.single.sql, isNot(contains('gmo.*')));
      expect(baseQueries.single.sql, isNot(contains('VerifiedBuild')));
      expect(baseQueries.single.sql.toLowerCase(), contains('order by'));
      expect(
        baseQueries.single.bindings.sublist(
          baseQueries.single.bindings.length - 2,
        ),
        [50, 50],
      );
      expect(localeQueries.single.sql, isNot(contains('*')));
      expect(localeQueries.single.sql.toLowerCase(), contains('order by'));
      expect(localeQueries.single.bindings, [50, 50]);
    });
  });

  group('GossipMenuOption inline base/locale identity', () {
    late _FakeGossipMenuOptionRepository baseRepository;
    late _FakeGossipMenuOptionLocaleRepository localeRepository;

    setUp(() {
      GetIt.instance.registerSingleton(EventBus(sync: true));
      baseRepository = _FakeGossipMenuOptionRepository([
        const GossipMenuOptionEntity(menuId: 10, optionId: 2),
      ]);
      localeRepository = _FakeGossipMenuOptionLocaleRepository([
        const GossipMenuOptionLocaleEntity(
          menuId: 10,
          optionId: 2,
          locale: 'zhCN',
          optionText: '旧文本',
        ),
      ]);
      GetIt.instance.registerSingleton<GossipMenuOptionRepository>(
        baseRepository,
      );
      GetIt.instance.registerSingleton<GossipMenuOptionLocaleRepository>(
        localeRepository,
      );
      final transaction = _FakeTransaction(baseRepository, localeRepository);
      final activityLogService = ActivityLogService(_FakeActivityRepository());
      GetIt.instance.registerSingleton(
        SaveGossipMenuOptionUseCase(
          transaction: transaction,
          optionRepository: baseRepository,
          localeRepository: localeRepository,
          activityLogService: activityLogService,
        ),
      );
      GetIt.instance.registerSingleton(
        CopyGossipMenuOptionUseCase(
          transaction: transaction,
          optionRepository: baseRepository,
          localeRepository: localeRepository,
          activityLogService: activityLogService,
        ),
      );
      GetIt.instance.registerSingleton(
        DestroyGossipMenuOptionUseCase(
          transaction: transaction,
          optionRepository: baseRepository,
          localeRepository: localeRepository,
          activityLogService: activityLogService,
        ),
      );
    });

    tearDown(() async {
      GetIt.instance.get<EventBus>().destroy();
      await GetIt.instance.reset();
    });

    test('编辑后 base 与 locale 分别用各自旧 key 更新', () async {
      final viewModel = GossipMenuOptionCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.setParentKey(10);
      await viewModel.edit(viewModel.items.value.single.key);
      const baseKey = GossipMenuOptionKey(menuId: 10, optionId: 2);
      const localeKey = GossipMenuOptionLocaleKey(
        menuId: 10,
        optionId: 2,
        locale: 'zhCN',
      );

      expect(viewModel.editingKey.value, baseKey);
      expect(viewModel.localeEditingKey.value, localeKey);
      viewModel.menuIdController.init(11);
      viewModel.optionIdController.init(3);
      viewModel.localeOptionTextController.init('新文本');
      await viewModel.persist();

      expect(baseRepository.updateKeys, [baseKey]);
      expect(localeRepository.updateKeys, [localeKey]);
      expect(localeRepository.rows.single.menuId, 11);
      expect(localeRepository.rows.single.optionId, 3);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.localeEditingKey.value, isNull);
    });

    test('locale 失败后回滚并保留旧 base/locale key，重试仍定位原记录', () async {
      final viewModel = GossipMenuOptionCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.setParentKey(10);
      await viewModel.edit(viewModel.items.value.single.key);
      const oldBaseKey = GossipMenuOptionKey(menuId: 10, optionId: 2);
      const oldLocaleKey = GossipMenuOptionLocaleKey(
        menuId: 10,
        optionId: 2,
        locale: 'zhCN',
      );
      viewModel.menuIdController.init(11);
      viewModel.optionIdController.init(3);
      viewModel.localeOptionTextController.init('新文本');
      localeRepository.failUpdates = true;

      await expectLater(viewModel.persist(), throwsA(isA<StateError>()));
      expect(viewModel.editingKey.value, oldBaseKey);
      expect(viewModel.localeEditingKey.value, oldLocaleKey);
      expect(viewModel.formVisible.value, isTrue);
      expect(baseRepository.rows.single.menuId, 10);
      expect(localeRepository.rows.single.menuId, 10);

      localeRepository.failUpdates = false;
      await viewModel.persist();
      expect(baseRepository.updateKeys, [oldBaseKey, oldBaseKey]);
      expect(localeRepository.updateKeys, [oldLocaleKey, oldLocaleKey]);
    });

    test('清空 locale 字段时使用原 locale key 删除，不使用已改 base key', () async {
      final viewModel = GossipMenuOptionCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.setParentKey(10);
      await viewModel.edit(viewModel.items.value.single.key);
      const oldLocaleKey = GossipMenuOptionLocaleKey(
        menuId: 10,
        optionId: 2,
        locale: 'zhCN',
      );
      viewModel.menuIdController.init(11);
      viewModel.optionIdController.init(3);
      viewModel.localeOptionTextController.init('');
      viewModel.localeBoxTextController.init('');

      await viewModel.persist();

      expect(localeRepository.destroyKeys, [oldLocaleKey]);
      expect(localeRepository.rows, isEmpty);
    });

    test('父范围变化和新建都会清空 persisted row identity', () async {
      final viewModel = GossipMenuOptionCollectionEditorViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.setParentKey(10);
      await viewModel.edit(viewModel.items.value.single.key);
      expect(viewModel.editingKey.value, isNotNull);

      await viewModel.setParentKey(12);
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.localeEditingKey.value, isNull);

      await viewModel.create();
      expect(viewModel.editingKey.value, isNull);
      expect(viewModel.localeEditingKey.value, isNull);
      expect(viewModel.menuIdController.collect(), 12);
    });

    test('复制 locale 失败时回滚新 base 和已复制 locale', () async {
      localeRepository.failStores = true;
      final useCase = GetIt.instance.get<CopyGossipMenuOptionUseCase>();

      await expectLater(
        useCase.execute(const GossipMenuOptionKey(menuId: 10, optionId: 2)),
        throwsA(isA<StateError>()),
      );

      expect(baseRepository.rows, hasLength(1));
      expect(
        GossipMenuOptionKey.fromEntity(baseRepository.rows.single),
        const GossipMenuOptionKey(menuId: 10, optionId: 2),
      );
      expect(localeRepository.rows, hasLength(1));
      expect(
        GossipMenuOptionLocaleKey.fromEntity(localeRepository.rows.single),
        const GossipMenuOptionLocaleKey(
          menuId: 10,
          optionId: 2,
          locale: 'zhCN',
        ),
      );
    });

    test('复制源不存在时抛出稳定错误且不产生目标记录', () async {
      final useCase = GetIt.instance.get<CopyGossipMenuOptionUseCase>();

      await expectLater(
        useCase.execute(const GossipMenuOptionKey(menuId: 99, optionId: 1)),
        throwsStateError,
      );

      expect(baseRepository.rows, hasLength(1));
      expect(localeRepository.rows, hasLength(1));
    });

    test('新增 base/locale 成功后返回两份具体 identity', () async {
      final useCase = GetIt.instance.get<SaveGossipMenuOptionUseCase>();
      const candidate = GossipMenuOptionEntity(menuId: 10, optionId: 3);
      const localeCandidate = GossipMenuOptionLocaleEntity(
        menuId: 10,
        optionId: 3,
        locale: 'zhCN',
        optionText: '新选项',
      );

      final result = await useCase.execute(
        const SaveGossipMenuOptionInput(
          originalKey: null,
          candidate: candidate,
          originalLocaleKey: null,
          localeCandidate: localeCandidate,
        ),
      );

      expect(result.persistedKey, GossipMenuOptionKey.fromEntity(candidate));
      expect(
        result.localeKey,
        GossipMenuOptionLocaleKey.fromEntity(localeCandidate),
      );
      expect(baseRepository.rows, hasLength(2));
      expect(localeRepository.rows, hasLength(2));
    });

    test('删除 base 失败时回滚已删除 locale', () async {
      baseRepository.failDestroys = true;
      final useCase = GetIt.instance.get<DestroyGossipMenuOptionUseCase>();
      const key = GossipMenuOptionKey(menuId: 10, optionId: 2);

      await expectLater(useCase.execute(key), throwsStateError);

      expect(baseRepository.rows, hasLength(1));
      expect(localeRepository.rows, hasLength(1));
      expect(
        GossipMenuOptionLocaleKey.fromEntity(localeRepository.rows.single),
        const GossipMenuOptionLocaleKey(
          menuId: 10,
          optionId: 2,
          locale: 'zhCN',
        ),
      );
    });
  });

  test('校验、UI 和 Repository 遵守 inline 编辑边界', () {
    final validation = _GossipMenuOptionValidation();
    expect(
      () => validation.validateGossipMenuOptionFields(
        const GossipMenuOptionEntity(menuId: 1, optionId: 32),
      ),
      throwsA(isA<StateError>()),
    );
    final baseRepository = readLocalDartLibrarySource('lib/repository/gossip_menu_option_repository.dart');
    final localeRepository = readLocalDartLibrarySource('lib/repository/gossip_menu_option_locale_repository.dart');
    final viewModel = File(
      'lib/page/gossip_menu/gossip_menu_option_collection_editor_view_model.dart',
    ).readAsStringSync();
    final view = File(
      'lib/page/gossip_menu/gossip_menu_option_view.dart',
    ).readAsStringSync();

    expect(baseRepository, isNot(contains('saveGossipMenuOption(')));
    expect(localeRepository, isNot(contains('saveGossipMenuOptionLocale(')));
    expect(
      viewModel,
      contains('final editingKey = signal<GossipMenuOptionKey?>'),
    );
    expect(viewModel, isNot(contains('_originalMenuId')));
    expect(viewModel, isNot(contains('destroyGossipMenuOptionLocales')));
    expect(view, isNot(contains('readOnly: true')));
    expect(view, contains('FoxyPagination('));
  });
}

class _FakeGossipMenuOptionRepository extends GossipMenuOptionRepository {
  final List<GossipMenuOptionEntity> rows;
  final updateKeys = <GossipMenuOptionKey>[];
  bool failDestroys = false;

  _FakeGossipMenuOptionRepository(this.rows);

  @override
  Future<int> countGossipMenuOptions(int menuId) async {
    return rows.where((row) => row.menuId == menuId).length;
  }

  @override
  Future<GossipMenuOptionEntity> createGossipMenuOption(int menuId) async {
    final used = rows
        .where((row) => row.menuId == menuId)
        .map((row) => row.optionId)
        .toSet();
    var optionId = 0;
    while (used.contains(optionId)) {
      optionId++;
    }
    return GossipMenuOptionEntity(menuId: menuId, optionId: optionId);
  }

  @override
  Future<List<BriefGossipMenuOptionEntity>> getBriefGossipMenuOptions(
    int menuId, {
    int page = 1,
  }) async {
    return rows
        .where((row) => row.menuId == menuId)
        .map(
          (row) => BriefGossipMenuOptionEntity(
            menuId: row.menuId,
            optionId: row.optionId,
            optionIcon: row.optionIcon,
            optionText: row.optionText,
            optionType: row.optionType,
            optionNpcFlag: row.optionNpcFlag,
            actionMenuId: row.actionMenuId,
          ),
        )
        .toList();
  }

  @override
  Future<GossipMenuOptionEntity?> getGossipMenuOption(
    GossipMenuOptionKey key,
  ) async {
    for (final row in rows) {
      if (GossipMenuOptionKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> storeGossipMenuOption(GossipMenuOptionEntity model) async {
    final key = GossipMenuOptionKey.fromEntity(model);
    if (rows.any((row) => GossipMenuOptionKey.fromEntity(row) == key)) {
      throw StateError('duplicate');
    }
    rows.add(model);
  }

  @override
  Future<void> destroyGossipMenuOption(GossipMenuOptionKey key) async {
    if (failDestroys) throw StateError('base destroy failed');
    final index = rows.indexWhere(
      (row) => GossipMenuOptionKey.fromEntity(row) == key,
    );
    if (index < 0) throw StateError('missing');
    rows.removeAt(index);
  }

  @override
  Future<void> updateGossipMenuOption(
    GossipMenuOptionKey originalKey,
    GossipMenuOptionEntity model,
  ) async {
    updateKeys.add(originalKey);
    final index = rows.indexWhere(
      (row) => GossipMenuOptionKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = model;
  }
}

class _FakeGossipMenuOptionLocaleRepository
    extends GossipMenuOptionLocaleRepository {
  final List<GossipMenuOptionLocaleEntity> rows;
  final destroyKeys = <GossipMenuOptionLocaleKey>[];
  bool failUpdates = false;
  bool failStores = false;
  final updateKeys = <GossipMenuOptionLocaleKey>[];

  _FakeGossipMenuOptionLocaleRepository(this.rows);

  @override
  Future<void> destroyGossipMenuOptionLocale(
    GossipMenuOptionLocaleKey key,
  ) async {
    destroyKeys.add(key);
    final index = rows.indexWhere(
      (row) => GossipMenuOptionLocaleKey.fromEntity(row) == key,
    );
    if (index < 0) throw StateError('missing');
    rows.removeAt(index);
  }

  @override
  Future<GossipMenuOptionLocaleEntity?> getGossipMenuOptionLocale(
    GossipMenuOptionLocaleKey key,
  ) async {
    for (final row in rows) {
      if (GossipMenuOptionLocaleKey.fromEntity(row) == key) return row;
    }
    return null;
  }

  @override
  Future<void> storeGossipMenuOptionLocale(
    GossipMenuOptionLocaleEntity model,
  ) async {
    if (failStores) throw StateError('locale store failed');
    rows.add(model);
  }

  @override
  Future<List<GossipMenuOptionLocaleEntity>>
  getGossipMenuOptionLocalesForOption(GossipMenuOptionKey key) async {
    return rows
        .where(
          (row) => row.menuId == key.menuId && row.optionId == key.optionId,
        )
        .toList();
  }

  @override
  Future<void> updateGossipMenuOptionLocale(
    GossipMenuOptionLocaleKey originalKey,
    GossipMenuOptionLocaleEntity model,
  ) async {
    updateKeys.add(originalKey);
    if (failUpdates) throw StateError('locale write failed');
    final index = rows.indexWhere(
      (row) => GossipMenuOptionLocaleKey.fromEntity(row) == originalKey,
    );
    if (index < 0) throw StateError('missing');
    rows[index] = model;
  }
}

final class _FakeTransaction extends DatabaseTransaction {
  _FakeTransaction(this.optionRepository, this.localeRepository);

  final _FakeGossipMenuOptionRepository optionRepository;
  final _FakeGossipMenuOptionLocaleRepository localeRepository;

  @override
  Future<void> execute(Future<void> Function() action) async {
    final optionSnapshot = List<GossipMenuOptionEntity>.of(
      optionRepository.rows,
    );
    final localeSnapshot = List<GossipMenuOptionLocaleEntity>.of(
      localeRepository.rows,
    );
    try {
      await action();
    } catch (_) {
      optionRepository.rows
        ..clear()
        ..addAll(optionSnapshot);
      localeRepository.rows
        ..clear()
        ..addAll(localeSnapshot);
      rethrow;
    }
  }
}

final class _FakeActivityRepository extends ActivityLogRepository {
  @override
  void storeActivityLogBestEffort(_) {}
}

class _GossipMenuOptionValidation
    with ViewModelValidationMixin, GossipMenuOptionValidationMixin {}

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

class _TestGossipMenuOptionRepository extends GossipMenuOptionRepository {
  @override
  final Laconic laconic;

  _TestGossipMenuOptionRepository(this.laconic);
}

class _TestGossipMenuOptionLocaleRepository
    extends GossipMenuOptionLocaleRepository {
  @override
  final Laconic laconic;

  _TestGossipMenuOptionLocaleRepository(this.laconic);
}
