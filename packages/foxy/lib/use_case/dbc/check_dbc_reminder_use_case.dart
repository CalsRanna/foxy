import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_progress.dart';
import 'package:foxy/infrastructure/dbc/dbc_sync_util.dart';
import 'package:get_it/get_it.dart';

/// Result of a startup DBC-missing check.
class DbcReminderCheckResult {
  /// All registered DBC tables that are currently missing (sorted).
  final List<String> missingTables;

  /// Tables that were not part of the last notified set — the ones that
  /// should trigger a reminder.
  final List<String> newlyMissing;

  const DbcReminderCheckResult({
    required this.missingTables,
    required this.newlyMissing,
  });

  bool get shouldRemind => newlyMissing.isNotEmpty;
}

/// Startup check that reminds the user when newly registered DBC tables
/// were never imported.
///
/// Compares the current missing set against the last-notified set persisted
/// in config ([notifiedKey]). A reminder fires only when the missing set
/// *grew* since the last notification; the current set is then persisted as
/// the new baseline. This covers the three scenarios:
/// - upgrade adds tables → first launch after upgrade reminds;
/// - user imports → no longer missing → no reminder;
/// - user ignores (e.g. the client directory lacks the .dbc files) → the
///   set is unchanged → no repeated nagging.
class CheckDbcReminderUseCase {
  /// Config key holding the table names that were missing at the last
  /// reminder.
  static const notifiedKey = 'dbc_missing_notified';

  final Future<List<DbcTableCheckResult>> Function() _checkTables;
  final ConfigUtil _configUtil;

  CheckDbcReminderUseCase({
    Future<List<DbcTableCheckResult>> Function()? checkTables,
    ConfigUtil? configUtil,
  }) : _checkTables = checkTables ?? (() => DbcSyncUtil().checkTables()),
       _configUtil = configUtil ?? GetIt.instance.get<ConfigUtil>();

  Future<DbcReminderCheckResult> execute() async {
    final results = await _checkTables();
    final missing =
        results
            .where((result) => result.state == DbcTableState.missing)
            .map((result) => result.tableName)
            .toList()
          ..sort();
    final config = await _configUtil.load();
    final notified =
        (config[notifiedKey] as List?)
            ?.map((name) => name.toString())
            .toSet() ??
        const <String>{};
    final newly = missing.where((name) => !notified.contains(name)).toList();
    if (newly.isNotEmpty) {
      await _configUtil.update({notifiedKey: missing});
    }
    return DbcReminderCheckResult(missingTables: missing, newlyMissing: newly);
  }
}
