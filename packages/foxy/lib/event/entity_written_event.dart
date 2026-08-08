import 'package:foxy/entity/activity_log_entity.dart';

/// Published after a business write (create/update/delete/copy) succeeded.
///
/// Carries the fully constructed [ActivityLogEntity] so every consumer of a
/// write gets the same log in one hop: the persistence aspect
/// ([ActivityLogListener]) writes it to `activity_log`, and the dashboard
/// prepends it to the recent-activity list without waiting for the write.
class EntityWrittenEvent {
  final ActivityLogEntity log;

  const EntityWrittenEvent(this.log);
}
