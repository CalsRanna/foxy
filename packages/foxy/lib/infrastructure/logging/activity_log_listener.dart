import 'dart:async';

import 'package:foxy/event/entity_written_event.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/logging/activity_log_service.dart';

/// The single persistence aspect for activity logging.
///
/// Subscribes to [EntityWrittenEvent] (published by generated view-model code
/// after a successful write) and records the carried log via the
/// best-effort [ActivityLogService] — logging must never turn a completed
/// business write into a failure.
///
/// The service is resolved lazily through [serviceFactory] at event time so
/// this eager singleton can be registered before the service's own
/// dependencies (e.g. `ActivityLogRepository`) are registered in DI.
final class ActivityLogListener {
  final EventBus _bus;
  final ActivityLogService Function() _serviceFactory;
  StreamSubscription<EntityWrittenEvent>? _sub;

  ActivityLogListener(this._bus, this._serviceFactory);

  void start() {
    _sub ??= _bus.on<EntityWrittenEvent>().listen(
      (event) => _serviceFactory().recordBestEffort(event.log),
    );
  }

  void dispose() {
    _sub?.cancel();
    _sub = null;
  }
}
