import 'dart:async';

import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/activity_logged_event.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:get_it/get_it.dart';

class ActivityLogRepository with RepositoryMixin {
  static const _table = 'foxy.activity_log';

  final _eventBus = GetIt.instance.get<EventBus>();

  Future<int> countActivityLogs() async {
    return laconic.table(_table).count();
  }

  Future<List<ActivityLogEntity>> getActivityLogs({int limit = 20}) async {
    final rows = await laconic
        .table(_table)
        .select(['id', 'module', 'action_type', 'entity_name', 'created_at'])
        .orderBy('id', direction: 'desc')
        .limit(limit)
        .get();
    return rows.map((row) => ActivityLogEntity.fromJson(row.toMap())).toList();
  }

  /// Strict write; failures throw, for callers that need confirmation the
  /// log was persisted.
  Future<void> storeActivityLog(ActivityLogEntity log) async {
    await laconic.table(_table).insert([log.toJson()]);
    _eventBus.fire(ActivityLoggedEvent(log));
  }

  /// Best-effort activity log: written asynchronously; failures are only
  /// logged and never affect the main business result.
  ///
  /// Use this when recording activity trails after a successful business
  /// operation, so fire-and-forget calls still have an error home.
  void storeActivityLogBestEffort(ActivityLogEntity log) {
    unawaited(_storeActivityLogSafe(log));
  }

  Future<void> _storeActivityLogSafe(ActivityLogEntity log) async {
    try {
      await storeActivityLog(log);
    } catch (e) {
      LoggerUtil.instance.e('写入活动日志失败: $e');
    }
  }
}
