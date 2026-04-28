import 'package:foxy/model/activity_log.dart';
import 'package:foxy/page/foxy_app/foxy_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

class ActivityLogRepository {
  Laconic get _laconic => GetIt.instance.get<FoxyViewModel>().laconic!;

  static const String _table = 'foxy.activity_log';

  Future<void> storeActivityLog(ActivityLog log) async {
    await _laconic.table(_table).insert([log.toJson()]);
  }

  Future<List<ActivityLog>> getRecentActivityLogs({int limit = 20}) async {
    final rows = await _laconic
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
