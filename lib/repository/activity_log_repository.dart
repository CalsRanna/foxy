import 'dart:async';

import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/activity_logged_event.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:foxy/event/event_bus.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:get_it/get_it.dart';

class ActivityLogRepository with RepositoryMixin {
  static const _table = 'foxy.activity_log';

  final _eventBus = GetIt.instance.get<EventBus>();

  Future<List<ActivityLogEntity>> getActivityLogs({int limit = 20}) async {
    final rows = await laconic
        .table(_table)
        .select(['*'])
        .orderBy('id', direction: 'desc')
        .limit(limit)
        .get();
    return rows.map((row) => ActivityLogEntity.fromJson(row.toMap())).toList();
  }

  Future<int> countActivityLogs() async {
    return laconic.table(_table).count();
  }

  /// 严格写入；失败会抛出，供需要确认落库的调用方使用。
  Future<void> storeActivityLog(ActivityLogEntity log) async {
    await laconic.table(_table).insert([log.toJson()]);
    _eventBus.fire(ActivityLoggedEvent(log));
  }

  /// Best-effort 活动日志：异步写入，失败只记日志，不影响主业务成功结果。
  ///
  /// 业务操作成功后记录活动轨迹时使用本方法，避免 fire-and-forget 无错误归宿。
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
