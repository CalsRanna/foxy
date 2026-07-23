import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/entity/npc_text_locale_entity.dart';
import 'package:foxy/entity/npc_text_locale_key.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/npc_text_locale_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/use_case/gossip_menu/destroy_npc_text_use_case.dart';
import 'package:foxy/use_case/gossip_menu/save_npc_text_use_case.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUp(() {
    GetIt.instance.registerSingleton(EventBus(sync: true));
  });

  tearDown(() async {
    GetIt.instance.get<EventBus>().destroy();
    await GetIt.instance.reset();
  });

  test('locale 写入失败时回滚 npc_text 主表更新', () async {
    final mainRepository = _NpcTextRepository({
      10: const NpcTextEntity(id: 10, text00: 'old'),
    });
    final localeRepository = _NpcTextLocaleRepository({
      const NpcTextLocaleKey(id: 10, locale: 'zhCN'): const NpcTextLocaleEntity(
        id: 10,
        locale: 'zhCN',
        text00: '旧文本',
      ),
    })..failWrites = true;
    final activityRepository = _ActivityLogRepository();
    final useCase = SaveNpcTextUseCase(
      transaction: _Transaction(mainRepository, localeRepository),
      npcTextRepository: mainRepository,
      localeRepository: localeRepository,
      activityLogService: ActivityLogService(activityRepository),
    );

    await expectLater(
      useCase.execute(
        const SaveNpcTextInput(
          originalKey: 10,
          candidate: NpcTextEntity(id: 11, text00: 'new'),
          originalLocaleKey: NpcTextLocaleKey(id: 10, locale: 'zhCN'),
          localeCandidate: NpcTextLocaleEntity(
            id: 11,
            locale: 'zhCN',
            text00: '新文本',
          ),
        ),
      ),
      throwsStateError,
    );

    expect(mainRepository.rows.keys, {10});
    expect(mainRepository.rows[10]?.text00, 'old');
    expect(localeRepository.rows.keys, {
      const NpcTextLocaleKey(id: 10, locale: 'zhCN'),
    });
    expect(activityRepository.logs, isEmpty);
  });

  test('事务成功后返回新的 base/locale identity 并记录活动', () async {
    final mainRepository = _NpcTextRepository({});
    final localeRepository = _NpcTextLocaleRepository({});
    final activityRepository = _ActivityLogRepository();
    final useCase = SaveNpcTextUseCase(
      transaction: _Transaction(mainRepository, localeRepository),
      npcTextRepository: mainRepository,
      localeRepository: localeRepository,
      activityLogService: ActivityLogService(activityRepository),
    );

    final result = await useCase.execute(
      const SaveNpcTextInput(
        originalKey: null,
        candidate: NpcTextEntity(id: 20, text00: 'base'),
        originalLocaleKey: null,
        localeCandidate: NpcTextLocaleEntity(
          id: 20,
          locale: 'zhCN',
          text00: '本地化',
        ),
      ),
    );

    expect(result.persistedKey, 20);
    expect(result.localeKey, const NpcTextLocaleKey(id: 20, locale: 'zhCN'));
    expect(mainRepository.rows.keys, {20});
    expect(localeRepository.rows.keys, {
      const NpcTextLocaleKey(id: 20, locale: 'zhCN'),
    });
    expect(activityRepository.logs, hasLength(1));
  });

  test('更新成功时用完整旧 identity 定位并返回修改后的 identity', () async {
    final mainRepository = _NpcTextRepository({
      10: const NpcTextEntity(id: 10, text00: 'old'),
    });
    final localeRepository = _NpcTextLocaleRepository({
      const NpcTextLocaleKey(id: 10, locale: 'zhCN'): const NpcTextLocaleEntity(
        id: 10,
        locale: 'zhCN',
        text00: '旧文本',
      ),
    });
    final useCase = SaveNpcTextUseCase(
      transaction: _Transaction(mainRepository, localeRepository),
      npcTextRepository: mainRepository,
      localeRepository: localeRepository,
      activityLogService: ActivityLogService(_ActivityLogRepository()),
    );

    final result = await useCase.execute(
      const SaveNpcTextInput(
        originalKey: 10,
        candidate: NpcTextEntity(id: 11, text00: 'new'),
        originalLocaleKey: NpcTextLocaleKey(id: 10, locale: 'zhCN'),
        localeCandidate: NpcTextLocaleEntity(
          id: 11,
          locale: 'deDE',
          text00: 'neu',
        ),
      ),
    );

    expect(mainRepository.updateKeys, [10]);
    expect(localeRepository.updateKeys, [
      const NpcTextLocaleKey(id: 10, locale: 'zhCN'),
    ]);
    expect(result.persistedKey, 11);
    expect(result.localeKey, const NpcTextLocaleKey(id: 11, locale: 'deDE'));
    expect(mainRepository.rows.keys, {11});
    expect(localeRepository.rows.keys, {
      const NpcTextLocaleKey(id: 11, locale: 'deDE'),
    });
  });

  test('原记录不存在时不写 locale', () async {
    final mainRepository = _NpcTextRepository({});
    final localeRepository = _NpcTextLocaleRepository({
      const NpcTextLocaleKey(id: 10, locale: 'zhCN'): const NpcTextLocaleEntity(
        id: 10,
        locale: 'zhCN',
      ),
    });
    final useCase = SaveNpcTextUseCase(
      transaction: _Transaction(mainRepository, localeRepository),
      npcTextRepository: mainRepository,
      localeRepository: localeRepository,
      activityLogService: ActivityLogService(_ActivityLogRepository()),
    );

    await expectLater(
      useCase.execute(
        const SaveNpcTextInput(
          originalKey: 10,
          candidate: NpcTextEntity(id: 11),
          originalLocaleKey: NpcTextLocaleKey(id: 10, locale: 'zhCN'),
          localeCandidate: NpcTextLocaleEntity(id: 11, locale: 'zhCN'),
        ),
      ),
      throwsStateError,
    );

    expect(mainRepository.rows, isEmpty);
    expect(localeRepository.rows.keys, {
      const NpcTextLocaleKey(id: 10, locale: 'zhCN'),
    });
  });

  test('identity 修改产生 duplicate 时事务不留下部分状态', () async {
    final mainRepository = _NpcTextRepository({
      10: const NpcTextEntity(id: 10),
      11: const NpcTextEntity(id: 11),
    });
    final localeRepository = _NpcTextLocaleRepository({});
    final useCase = SaveNpcTextUseCase(
      transaction: _Transaction(mainRepository, localeRepository),
      npcTextRepository: mainRepository,
      localeRepository: localeRepository,
      activityLogService: ActivityLogService(_ActivityLogRepository()),
    );

    await expectLater(
      useCase.execute(
        const SaveNpcTextInput(
          originalKey: 10,
          candidate: NpcTextEntity(id: 11),
          originalLocaleKey: null,
          localeCandidate: null,
        ),
      ),
      throwsStateError,
    );

    expect(mainRepository.rows.keys, {10, 11});
  });

  test('失败后重试仍使用完整原始 base/locale key', () async {
    final mainRepository = _NpcTextRepository({
      10: const NpcTextEntity(id: 10),
    });
    final localeRepository = _NpcTextLocaleRepository({
      const NpcTextLocaleKey(id: 10, locale: 'zhCN'): const NpcTextLocaleEntity(
        id: 10,
        locale: 'zhCN',
      ),
    })..failWrites = true;
    final useCase = SaveNpcTextUseCase(
      transaction: _Transaction(mainRepository, localeRepository),
      npcTextRepository: mainRepository,
      localeRepository: localeRepository,
      activityLogService: ActivityLogService(_ActivityLogRepository()),
    );
    const input = SaveNpcTextInput(
      originalKey: 10,
      candidate: NpcTextEntity(id: 11),
      originalLocaleKey: NpcTextLocaleKey(id: 10, locale: 'zhCN'),
      localeCandidate: NpcTextLocaleEntity(id: 11, locale: 'deDE'),
    );

    await expectLater(useCase.execute(input), throwsStateError);
    localeRepository.failWrites = false;
    await useCase.execute(input);

    expect(mainRepository.updateKeys, [10, 10]);
    expect(localeRepository.updateKeys, [
      const NpcTextLocaleKey(id: 10, locale: 'zhCN'),
      const NpcTextLocaleKey(id: 10, locale: 'zhCN'),
    ]);
  });

  test('best-effort 日志同步失败不影响已完成的主操作', () async {
    final mainRepository = _NpcTextRepository({});
    final localeRepository = _NpcTextLocaleRepository({});
    final activityRepository = _ActivityLogRepository()..failWrites = true;
    final useCase = SaveNpcTextUseCase(
      transaction: _Transaction(mainRepository, localeRepository),
      npcTextRepository: mainRepository,
      localeRepository: localeRepository,
      activityLogService: ActivityLogService(activityRepository),
    );

    final result = await useCase.execute(
      const SaveNpcTextInput(
        originalKey: null,
        candidate: NpcTextEntity(id: 30),
        originalLocaleKey: null,
        localeCandidate: null,
      ),
    );

    expect(result.persistedKey, 30);
    expect(mainRepository.rows.keys, {30});
  });

  test('删除主表失败时回滚已删除 locale', () async {
    final mainRepository = _NpcTextRepository({10: const NpcTextEntity(id: 10)})
      ..failDestroys = true;
    final localeRepository = _NpcTextLocaleRepository({
      const NpcTextLocaleKey(id: 10, locale: 'zhCN'): const NpcTextLocaleEntity(
        id: 10,
        locale: 'zhCN',
      ),
    });
    final useCase = DestroyNpcTextUseCase(
      transaction: _Transaction(mainRepository, localeRepository),
      npcTextRepository: mainRepository,
      localeRepository: localeRepository,
      activityLogService: ActivityLogService(_ActivityLogRepository()),
    );

    await expectLater(
      useCase.execute(
        const DestroyNpcTextInput(
          key: 10,
          localeKey: NpcTextLocaleKey(id: 10, locale: 'zhCN'),
        ),
      ),
      throwsStateError,
    );

    expect(mainRepository.rows.keys, {10});
    expect(localeRepository.rows.keys, {
      const NpcTextLocaleKey(id: 10, locale: 'zhCN'),
    });
  });
}

final class _Transaction extends DatabaseTransaction {
  _Transaction(this.mainRepository, this.localeRepository);

  final _NpcTextRepository mainRepository;
  final _NpcTextLocaleRepository localeRepository;

  @override
  Future<void> execute(Future<void> Function() action) async {
    final mainSnapshot = Map<int, NpcTextEntity>.of(mainRepository.rows);
    final localeSnapshot = Map<NpcTextLocaleKey, NpcTextLocaleEntity>.of(
      localeRepository.rows,
    );
    try {
      await action();
    } catch (_) {
      mainRepository.rows
        ..clear()
        ..addAll(mainSnapshot);
      localeRepository.rows
        ..clear()
        ..addAll(localeSnapshot);
      rethrow;
    }
  }
}

final class _NpcTextRepository extends NpcTextRepository {
  _NpcTextRepository(this.rows);

  final Map<int, NpcTextEntity> rows;
  final updateKeys = <int>[];
  bool failDestroys = false;

  @override
  Future<void> destroyNpcText(int key) async {
    if (failDestroys) throw StateError('main destroy failed');
    if (rows.remove(key) == null) throw StateError('missing main');
  }

  @override
  Future<void> storeNpcText(NpcTextEntity npcText) async {
    if (rows.containsKey(npcText.id)) throw StateError('duplicate main');
    rows[npcText.id] = npcText;
  }

  @override
  Future<void> updateNpcText(int originalKey, NpcTextEntity npcText) async {
    updateKeys.add(originalKey);
    if (!rows.containsKey(originalKey)) throw StateError('missing main');
    if (npcText.id != originalKey && rows.containsKey(npcText.id)) {
      throw StateError('duplicate main');
    }
    rows
      ..remove(originalKey)
      ..[npcText.id] = npcText;
  }
}

final class _NpcTextLocaleRepository extends NpcTextLocaleRepository {
  _NpcTextLocaleRepository(this.rows);

  final Map<NpcTextLocaleKey, NpcTextLocaleEntity> rows;
  bool failWrites = false;
  final updateKeys = <NpcTextLocaleKey>[];

  @override
  Future<void> storeNpcTextLocale(NpcTextLocaleEntity model) async {
    if (failWrites) throw StateError('locale failed');
    final key = NpcTextLocaleKey.fromEntity(model);
    if (rows.containsKey(key)) throw StateError('duplicate locale');
    rows[key] = model;
  }

  @override
  Future<void> updateNpcTextLocale(
    NpcTextLocaleKey originalKey,
    NpcTextLocaleEntity model,
  ) async {
    updateKeys.add(originalKey);
    if (failWrites) throw StateError('locale failed');
    if (!rows.containsKey(originalKey)) throw StateError('missing locale');
    final nextKey = NpcTextLocaleKey.fromEntity(model);
    if (nextKey != originalKey && rows.containsKey(nextKey)) {
      throw StateError('duplicate locale');
    }
    rows
      ..remove(originalKey)
      ..[nextKey] = model;
  }

  @override
  Future<void> destroyNpcTextLocale(NpcTextLocaleKey key) async {
    if (failWrites) throw StateError('locale failed');
    rows.remove(key);
  }
}

final class _ActivityLogRepository extends ActivityLogRepository {
  final logs = <ActivityLogEntity>[];
  bool failWrites = false;

  @override
  Future<void> storeActivityLog(ActivityLogEntity log) async {
    logs.add(log);
  }

  @override
  void storeActivityLogBestEffort(ActivityLogEntity log) {
    if (failWrites) throw StateError('log failed');
    logs.add(log);
  }
}
