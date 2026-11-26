import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/repository/activity_log_repository.dart';
import 'package:foxy/use_case/activity_log/activity_log_listener.dart';
import 'package:foxy/use_case/activity_log/activity_log_service.dart';
import 'package:test/test.dart';

void main() {
  test('Listens for EntityWrittenEvent and persists the log on a best-effort basis', () async {
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
    // The bus delivers synchronously. The log write runs asynchronously,
    // so let pending microtasks finish.
    await Future<void>.delayed(Duration.zero);

    expect(repository.logs, hasLength(1));
    expect(repository.logs.single.module, 'sample');
    expect(repository.logs.single.actionType, ActivityActionType.create);
    expect(repository.logs.single.entityName, '示例');
  });

  test('Disposal stops event delivery', () async {
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

class _RecordingActivityLogRepository extends ActivityLogRepository {
  final logs = <ActivityLogEntity>[];

  @override
  Future<void> storeActivityLog(ActivityLogEntity log) async {
    logs.add(log);
  }
}
