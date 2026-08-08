import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/activity_log_listener.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:test/test.dart';

class _RecordingActivityLogRepository extends ActivityLogRepository {
  final logs = <ActivityLogEntity>[];

  @override
  Future<void> storeActivityLog(ActivityLogEntity log) async {
    logs.add(log);
  }
}

void main() {
  test('监听 EntityWrittenEvent 并 best-effort 落库', () async {
    final bus = EventBus(sync: true);
    final repository = _RecordingActivityLogRepository();
    final listener = ActivityLogListener(
      bus,
      () => ActivityLogService(repository),
    )..start();
    addTearDown(() {
      listener.dispose();
      bus.destroy();
    });

    bus.fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'sample',
          actionType: ActivityActionType.create,
          entityName: '示例',
          createdAt: DateTime(2026, 8, 8),
        ),
      ),
    );
    // sync bus → 同步投递; service.recordBestEffort 是 unawaited 异步,
    // 需要让微任务跑完
    await Future<void>.delayed(Duration.zero);

    expect(repository.logs, hasLength(1));
    expect(repository.logs.single.module, 'sample');
    expect(repository.logs.single.actionType, ActivityActionType.create);
    expect(repository.logs.single.entityName, '示例');
  });

  test('dispose 后不再投递', () async {
    final bus = EventBus(sync: true);
    final repository = _RecordingActivityLogRepository();
    final listener = ActivityLogListener(
      bus,
      () => ActivityLogService(repository),
    )..start();
    listener.dispose();

    bus.fire(
      EntityWrittenEvent(
        ActivityLogEntity(
          module: 'sample',
          actionType: ActivityActionType.delete,
          entityName: 'x',
          createdAt: DateTime(2026, 8, 8),
        ),
      ),
    );
    await Future<void>.delayed(Duration.zero);

    expect(repository.logs, isEmpty);
    bus.destroy();
  });
}
