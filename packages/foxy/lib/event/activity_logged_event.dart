import 'package:foxy/entity/activity_log_entity.dart';

/// Domain event fired after an activity log entry is written to the
/// database.
///
/// Published by [ActivityLogRepository.storeActivityLog] after a successful
/// write, so modules like the dashboard can subscribe and refresh in real
/// time.
class ActivityLoggedEvent {
  final ActivityLogEntity log;
  const ActivityLoggedEvent(this.log);
}
