import 'dart:async';

import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ActivityLogRepository with RepositoryMixin {
  static const String _table = 'foxy.activity_log';

  final _activityLoggedController =
      StreamController<ActivityLogEntity>.broadcast();

  /// 每次成功写入活动日志后触发，供订阅方（如仪表盘的「动态」）实时刷新。
  Stream<ActivityLogEntity> get activityLogged =>
      _activityLoggedController.stream;

  Future<void> storeActivityLog(ActivityLogEntity log) async {
    await laconic.table(_table).insert([log.toJson()]);
    _activityLoggedController.add(log);
  }

  Future<List<ActivityLogEntity>> getRecentActivityLogs({
    int limit = 20,
  }) async {
    final rows = await laconic
        .table(_table)
        .select(['*'])
        .orderBy('id', direction: 'desc')
        .limit(limit)
        .get();

    return rows.map((row) => ActivityLogEntity.fromJson(row.toMap())).toList();
  }
}
