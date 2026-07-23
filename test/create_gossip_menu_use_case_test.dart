import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/entity/gossip_menu_entity.dart';
import 'package:foxy/entity/gossip_menu_key.dart';
import 'package:foxy/entity/npc_text_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/repository/gossip_menu_repository.dart';
import 'package:foxy/repository/npc_text_repository.dart';
import 'package:foxy/use_case/gossip_menu/create_gossip_menu_use_case.dart';
import 'package:get_it/get_it.dart';

void main() {
  setUp(() {
    GetIt.instance.registerSingleton(EventBus(sync: true));
  });

  tearDown(() async {
    GetIt.instance.get<EventBus>().destroy();
    await GetIt.instance.reset();
  });

  test('预留文本 identity 未改动时在同一事务创建 npc_text 和菜单', () async {
    final gossipRepository = _GossipMenuRepository({});
    final npcTextRepository = _NpcTextRepository({});
    final activityRepository = _ActivityLogRepository();
    final useCase = _createUseCase(
      gossipRepository,
      npcTextRepository,
      activityRepository,
    );

    await useCase.execute(
      const CreateGossipMenuInput(
        candidate: GossipMenuEntity(menuId: 10, textId: 20),
        reservedTextId: 20,
      ),
    );

    expect(gossipRepository.rows.keys, {
      const GossipMenuKey(menuId: 10, textId: 20),
    });
    expect(npcTextRepository.rows.keys, {20});
    expect(activityRepository.logs, hasLength(1));
  });

  test('用户改用已有文本 identity 时不创建预留 npc_text', () async {
    final gossipRepository = _GossipMenuRepository({});
    final npcTextRepository = _NpcTextRepository({
      30: const NpcTextEntity(id: 30),
    });
    final useCase = _createUseCase(
      gossipRepository,
      npcTextRepository,
      _ActivityLogRepository(),
    );

    await useCase.execute(
      const CreateGossipMenuInput(
        candidate: GossipMenuEntity(menuId: 10, textId: 30),
        reservedTextId: 20,
      ),
    );

    expect(npcTextRepository.storeKeys, isEmpty);
    expect(npcTextRepository.rows.keys, {30});
  });

  test('第二个 Repository 失败时回滚刚创建的 npc_text', () async {
    final gossipRepository = _GossipMenuRepository({})..failWrites = true;
    final npcTextRepository = _NpcTextRepository({});
    final activityRepository = _ActivityLogRepository();
    final useCase = _createUseCase(
      gossipRepository,
      npcTextRepository,
      activityRepository,
    );

    await expectLater(
      useCase.execute(
        const CreateGossipMenuInput(
          candidate: GossipMenuEntity(menuId: 10, textId: 20),
          reservedTextId: 20,
        ),
      ),
      throwsStateError,
    );

    expect(gossipRepository.rows, isEmpty);
    expect(npcTextRepository.rows, isEmpty);
    expect(activityRepository.logs, isEmpty);
  });

  test('菜单 duplicate 时事务回滚且可用同一完整 identity 重试', () async {
    const key = GossipMenuKey(menuId: 10, textId: 20);
    final gossipRepository = _GossipMenuRepository({
      key: const GossipMenuEntity(menuId: 10, textId: 20),
    });
    final npcTextRepository = _NpcTextRepository({});
    final useCase = _createUseCase(
      gossipRepository,
      npcTextRepository,
      _ActivityLogRepository(),
    );
    const input = CreateGossipMenuInput(
      candidate: GossipMenuEntity(menuId: 10, textId: 20),
      reservedTextId: 20,
    );

    await expectLater(useCase.execute(input), throwsStateError);
    expect(npcTextRepository.rows, isEmpty);
    gossipRepository.rows.clear();
    await useCase.execute(input);

    expect(gossipRepository.storeKeys, [key, key]);
    expect(npcTextRepository.storeKeys, [20, 20]);
    expect(gossipRepository.rows.keys, {key});
    expect(npcTextRepository.rows.keys, {20});
  });

  test('best-effort 日志同步失败不影响主事务结果', () async {
    final gossipRepository = _GossipMenuRepository({});
    final npcTextRepository = _NpcTextRepository({});
    final activityRepository = _ActivityLogRepository()..failWrites = true;
    final useCase = _createUseCase(
      gossipRepository,
      npcTextRepository,
      activityRepository,
    );

    await useCase.execute(
      const CreateGossipMenuInput(
        candidate: GossipMenuEntity(menuId: 10, textId: 20),
        reservedTextId: 20,
      ),
    );

    expect(gossipRepository.rows, hasLength(1));
    expect(npcTextRepository.rows, hasLength(1));
  });
}

CreateGossipMenuUseCase _createUseCase(
  _GossipMenuRepository gossipRepository,
  _NpcTextRepository npcTextRepository,
  _ActivityLogRepository activityRepository,
) {
  return CreateGossipMenuUseCase(
    transaction: _Transaction(gossipRepository, npcTextRepository),
    gossipMenuRepository: gossipRepository,
    npcTextRepository: npcTextRepository,
    activityLogService: ActivityLogService(activityRepository),
  );
}

final class _Transaction extends DatabaseTransaction {
  _Transaction(this.gossipRepository, this.npcTextRepository);

  final _GossipMenuRepository gossipRepository;
  final _NpcTextRepository npcTextRepository;

  @override
  Future<void> execute(Future<void> Function() action) async {
    final gossipSnapshot = Map<GossipMenuKey, GossipMenuEntity>.of(
      gossipRepository.rows,
    );
    final npcTextSnapshot = Map<int, NpcTextEntity>.of(npcTextRepository.rows);
    try {
      await action();
    } catch (_) {
      gossipRepository.rows
        ..clear()
        ..addAll(gossipSnapshot);
      npcTextRepository.rows
        ..clear()
        ..addAll(npcTextSnapshot);
      rethrow;
    }
  }
}

final class _GossipMenuRepository extends GossipMenuRepository {
  _GossipMenuRepository(this.rows);

  final Map<GossipMenuKey, GossipMenuEntity> rows;
  final storeKeys = <GossipMenuKey>[];
  bool failWrites = false;

  @override
  Future<void> storeGossipMenu(GossipMenuEntity menu) async {
    final key = GossipMenuKey.fromEntity(menu);
    storeKeys.add(key);
    if (failWrites) throw StateError('gossip write failed');
    if (rows.containsKey(key)) throw StateError('duplicate gossip');
    rows[key] = menu;
  }
}

final class _NpcTextRepository extends NpcTextRepository {
  _NpcTextRepository(this.rows);

  final Map<int, NpcTextEntity> rows;
  final storeKeys = <int>[];

  @override
  Future<void> storeNpcText(NpcTextEntity npcText) async {
    storeKeys.add(npcText.id);
    if (rows.containsKey(npcText.id)) throw StateError('duplicate npc text');
    rows[npcText.id] = npcText;
  }
}

final class _ActivityLogRepository extends ActivityLogRepository {
  final logs = <ActivityLogEntity>[];
  bool failWrites = false;

  @override
  void storeActivityLogBestEffort(ActivityLogEntity log) {
    if (failWrites) throw StateError('log failed');
    logs.add(log);
  }
}
