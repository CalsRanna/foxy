import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/gossip_menu_option_entity.dart';
import 'package:foxy/entity/gossip_menu_option_locale_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/exception/foxy_exceptions.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gossip_menu_option_locale_repository.dart';
import 'package:foxy/repository/gossip_menu_option_repository.dart';
import 'package:foxy/use_case/activity_log/activity_log_service.dart';
import 'package:foxy/use_case/gossip_menu/destroy_gossip_menu_option_use_case.dart';
import 'package:foxy/use_case/gossip_menu/save_gossip_menu_option_use_case.dart';
import 'package:foxy/view_model/gossip_menu_option_linked_list_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

import 'inline_editing_expectations.dart';
import 'repository_contract.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GossipMenuOption typed row identity', () {
    test(
      'Base and locale keys use all composite key columns for value equality',
      () {
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
            GossipMenuOptionLocaleKey.fromEntity(
              locale.copyWith(locale: 'deDE'),
            ),
          ),
        );
      },
    );
  });

  group('GossipMenuOption repositories write contract', () {
    group('GossipMenuOptionRepository', () {
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

      testRepositoryWrites(
        createRepository: _TestGossipMenuOptionRepository.new,
        originalKey: originalKey,
        candidate: candidate,
        missingCandidate: const GossipMenuOptionEntity(),
        update: (repository, key, row) =>
            repository.updateGossipMenuOption(key, row),
        destroy: (repository, key) => repository.destroyGossipMenuOption(key),
        expectedBindings: [
          ...candidate.toJson().values,
          originalKey.menuId,
          originalKey.optionId,
        ],
      );
    });

    group('GossipMenuOptionLocaleRepository', () {
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

      testRepositoryWrites(
        createRepository: _TestGossipMenuOptionLocaleRepository.new,
        originalKey: originalKey,
        candidate: candidate,
        missingCandidate: const GossipMenuOptionLocaleEntity(),
        update: (repository, key, row) =>
            repository.updateGossipMenuOptionLocale(key, row),
        destroy: (repository, key) =>
            repository.destroyGossipMenuOptionLocale(key),
        expectedBindings: [
          ...candidate.toJson().values,
          originalKey.menuId,
          originalKey.optionId,
          originalKey.locale,
        ],
      );
    });

    group('base', () {
      testBriefPagination(
        queryPageTwo: (laconic) =>
            _TestGossipMenuOptionRepository(laconic)
                .getBriefGossipMenuOptions(10, page: 2),
        tableAlias: 'gmo',
        verifyQuery: (query) =>
            expect(query.sql, isNot(contains('VerifiedBuild'))),
      );
    });

    group('locale', () {
      testBriefPagination(
        queryPageTwo: (laconic) =>
            _TestGossipMenuOptionLocaleRepository(laconic)
                .getBriefGossipMenuOptionLocales(page: 2),
        verifyQuery: (query) => expect(query.bindings, [50, 50]),
      );
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

    test('Editing the base row updates by its old key and leaves locale rows intact', () async {
      final viewModel = GossipMenuOptionLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.setLinkKey(10);
      await viewModel.edit(viewModel.items.value.single.key);
      const baseKey = GossipMenuOptionKey(menuId: 10, optionId: 2);

      expect(viewModel.editingKey.value, baseKey);
      viewModel.menuIdController.init(11);
      viewModel.optionIdController.init(3);
      await viewModel.persist();

      expect(baseRepository.updateKeys, [baseKey]);
      expect(localeRepository.updateKeys, isEmpty);
      expect(localeRepository.destroyKeys, isEmpty);
      expect(localeRepository.rows.single.menuId, 10);
      expect(localeRepository.rows.single.optionId, 2);
      expect(viewModel.items.value, isEmpty);
      expect(viewModel.editingKey.value, isNull);
    });

    test('Saving the base row preserves existing locale rows', () async {
      final viewModel = GossipMenuOptionLinkedListViewModel();
      addTearDown(viewModel.dispose);
      await viewModel.setLinkKey(10);
      await viewModel.edit(viewModel.items.value.single.key);
      viewModel.menuIdController.init(11);
      viewModel.optionIdController.init(3);

      await viewModel.persist();

      expect(localeRepository.destroyKeys, isEmpty);
      expect(localeRepository.rows, hasLength(1));
      expect(localeRepository.rows.single.menuId, 10);
    });

    test(
      'Changing the parent scope and creating clear the persisted row identity',
      () async {
        final viewModel = GossipMenuOptionLinkedListViewModel();
        addTearDown(viewModel.dispose);
        await viewModel.setLinkKey(10);
        await viewModel.edit(viewModel.items.value.single.key);
        expect(viewModel.editingKey.value, isNotNull);

        await expectParentChangeAndCreateClearIdentity(
          editingKey: viewModel.editingKey,
          selectedKey: viewModel.selectedKey,
          changeParent: () => viewModel.setLinkKey(12),
          create: viewModel.create,
        );
        expect(viewModel.menuIdController.collect(), 12);
      },
    );

    test('Copy duplicates the main row only', () async {
      await baseRepository.copyGossipMenuOption(
        const GossipMenuOptionKey(menuId: 10, optionId: 2),
      );

      // Copying creates a new parent row.
      expect(baseRepository.rows, hasLength(2));
      // The locale table still has only the source row.
      expect(localeRepository.rows, hasLength(1));
      // The locale row still points to the source key.
      final locale = localeRepository.rows.single;
      expect(locale.menuId, 10);
      expect(locale.optionId, 2);
    });

    test('Copying a missing source reports a stable error and creates no destination row', () async {
      await expectLater(
        baseRepository.copyGossipMenuOption(
          const GossipMenuOptionKey(menuId: 99, optionId: 1),
        ),
        throwsA(isA<RecordNotFoundException>()),
      );

      expect(baseRepository.rows, hasLength(1));
      expect(localeRepository.rows, hasLength(1));
    });

    test(
      'Creating base and locale rows returns both concrete identities',
      () async {
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
      },
    );

    test('A failed base delete rolls back deleted locale rows', () async {
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
}

final class _FakeActivityRepository extends ActivityLogRepository {
  @override
  void storeActivityLogBestEffort(_) {}
}

class _FakeGossipMenuOptionLocaleRepository
    extends GossipMenuOptionLocaleRepository {
  final List<GossipMenuOptionLocaleEntity> rows;
  final destroyKeys = <GossipMenuOptionLocaleKey>[];
  bool failUpdates = false;
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
  Future<List<GossipMenuOptionLocaleEntity>>
  getGossipMenuOptionLocalesForOption(GossipMenuOptionKey key) async {
    return rows
        .where(
          (row) => row.menuId == key.menuId && row.optionId == key.optionId,
        )
        .toList();
  }

  @override
  Future<void> storeGossipMenuOptionLocale(
    GossipMenuOptionLocaleEntity model,
  ) async {
    rows.add(model);
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
  Future<void> destroyGossipMenuOption(GossipMenuOptionKey key) async {
    if (failDestroys) throw StateError('base destroy failed');
    final index = rows.indexWhere(
      (row) => GossipMenuOptionKey.fromEntity(row) == key,
    );
    if (index < 0) throw StateError('missing');
    rows.removeAt(index);
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

final class _FakeTransaction extends DatabaseTransaction {
  final _FakeGossipMenuOptionRepository optionRepository;

  final _FakeGossipMenuOptionLocaleRepository localeRepository;
  _FakeTransaction(this.optionRepository, this.localeRepository);

  @override
  Future<T> execute<T>(Future<T> Function() action) async {
    final optionSnapshot = List<GossipMenuOptionEntity>.of(
      optionRepository.rows,
    );
    final localeSnapshot = List<GossipMenuOptionLocaleEntity>.of(
      localeRepository.rows,
    );
    try {
      return await action();
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

class _TestGossipMenuOptionLocaleRepository
    extends GossipMenuOptionLocaleRepository {
  @override
  final Laconic laconic;

  _TestGossipMenuOptionLocaleRepository(this.laconic);
}

class _TestGossipMenuOptionRepository extends GossipMenuOptionRepository {
  @override
  final Laconic laconic;

  _TestGossipMenuOptionRepository(this.laconic);
}
