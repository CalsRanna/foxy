import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/repository/activity_log_repository.dart';

final class ActivityLogService {
  final ActivityLogRepository _repository;
  final EventBus? _eventBus;

  ActivityLogService(this._repository, [this._eventBus]);

  void publishBestEffort(ActivityLogEntity log) {
    final bus = _eventBus;
    if (bus == null) {
      EntityWrittenEvent.dispatch(log, recordBestEffort);
    } else {
      EntityWrittenEvent.publish(bus, log);
    }
  }

  void recordBestEffort(ActivityLogEntity log) {
    try {
      _repository.storeActivityLogBestEffort(log);
    } catch (_) {
      // Activity logging must never turn a completed primary write into failure.
    }
  }
}
