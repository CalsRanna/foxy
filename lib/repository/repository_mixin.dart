import 'package:foxy/database/database.dart';
import 'package:foxy/infrastructure/preferences/locale_query_settings.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

mixin RepositoryMixin {
  final kPageSize = 50;
  Laconic get laconic => Database.instance.laconic;

  /// 是否 JOIN `*_locale` 表显示本地化名称。
  ///
  /// 读取基础设施层的 locale 查询设置；DI 未就绪时默认启用。
  bool get localeEnabled {
    try {
      return GetIt.instance.get<LocaleQuerySettings>().localeEnabled;
    } catch (_) {
      return true;
    }
  }

  /// 主键下一序号：`MAX(column) + 1`，空表默认从 `1`。
  ///
  /// [table] 为表名（DBC 可用 `foxy.dbc_*` 全名）。
  /// [column] 为主键列名（如 `ID` / `entry`）。
  /// [where] 可选范围条件，用于「父键下子序号」：
  /// `nextMaxPlusOne(_table, 'ID', where: {'CreatureID': creatureId})`。
  /// [firstValue] 为当前范围没有记录时返回的起始值。
  ///
  /// 约定：
  /// - [create*] 调用本方法预填只读主键，**不落库**；
  /// - [store*] 若实体主键 `> 0` 则沿用，否则再取下一号。
  Future<int> nextMaxPlusOne(
    String table,
    String column, {
    Map<String, Object?> where = const {},
    int firstValue = 1,
  }) async {
    var builder = laconic.table(table).select(['MAX(`$column`) AS max_id']);
    for (final entry in where.entries) {
      builder = builder.where(entry.key, entry.value);
    }
    final result = await builder.first();
    final raw = result.toMap()['max_id'];
    if (raw == null) return firstValue;
    if (raw is int) return raw + 1;
    if (raw is num) return raw.toInt() + 1;
    return (int.tryParse(raw.toString()) ?? 0) + 1;
  }
}
