import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/database/database_transaction.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/model/activity_log_details.dart';

/// Published after a business write (create/update/delete/copy) succeeded.
///
/// Carries the fully constructed [ActivityLogEntity] so every consumer of a
/// write gets the same log in one hop: the persistence aspect
/// ([ActivityLogListener]) writes it to `activity_log`, and the dashboard
/// prepends it to the recent-activity list without waiting for the write.
class EntityWrittenEvent {
  final ActivityLogEntity log;

  const EntityWrittenEvent(this.log);

  static Future<T> capture<T>(
    Future<T> Function() action, {
    Map<String, Object?>? sourceKey,
  }) => ActivityLogCapture.run(action, sourceKey: sourceKey);

  static void dispatch(
    ActivityLogEntity log,
    void Function(ActivityLogEntity) deliver,
  ) {
    final capture = ActivityLogCapture.current;
    DatabaseTransaction.afterCommit(() {
      try {
        if (log.actionType == ActivityActionType.update &&
            capture?.isUnchanged == true) {
          return;
        }
        deliver(log.copyWith(details: log.details ?? capture?.details));
      } catch (error) {
        LoggerUtil.instance.e('发布活动日志失败', error: error);
      }
    });
  }

  static void publish(EventBus bus, ActivityLogEntity log) =>
      dispatch(log, (activity) => bus.fire(EntityWrittenEvent(activity)));
}
