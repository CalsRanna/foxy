import 'package:foxy/entity/activity_log_entity.dart';
import 'package:foxy/event/activity_logged_event.dart';
import 'package:foxy/repository/repository_mixin.dart';
import 'package:foxy/util/event_bus.dart';
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

  Future<void> storeActivityLog(ActivityLogEntity log) async {
    await laconic.table(_table).insert([log.toJson()]);
    _eventBus.fire(ActivityLoggedEvent(log));
  }
}