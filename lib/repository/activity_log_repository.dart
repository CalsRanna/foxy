import 'package:foxy/model/activity_log.dart';
import 'package:foxy/repository/repository_mixin.dart';

class ActivityLogRepository with RepositoryMixin {
  static const String _table = 'foxy.activity_log';

  Future<void> storeActivityLog(ActivityLog log) async {
    await laconic.table(_table).insert([log.toJson()]);
  }

  Future<List<ActivityLog>> getRecentActivityLogs({int limit = 20}) async {
    final rows = await laconic
        .table(_table)
        .select(['*'])
        .orderBy('id', direction: 'desc')
        .limit(limit)
        .get();

    return rows
        .map((row) => ActivityLog.fromJson(row.toMap()))
        .toList();
  }
}
