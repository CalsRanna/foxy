import 'package:foxy/database/database.dart';
import 'package:foxy/infrastructure/preferences/locale_query_settings.dart';
import 'package:get_it/get_it.dart';
import 'package:laconic/laconic.dart';

// 导出给生成 part:仓储的 .g.dart 是 part of 父库,不能自己 import,
// 生成代码里的 FoxyException 抛掷点靠本文件的 import 作用域解析。
export 'package:foxy/infrastructure/errors/foxy_exceptions.dart';

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

  /// 把 Entity `toJson()` 的物理列名包装成反引号标识符，用于写入语句。
  ///
  /// laconic 不转义标识符，列名会原样拼进 SQL。统一加反引号后，
  /// `index`、`rank` 这类 MySQL 保留字列不需要逐个登记白名单。
  Map<String, dynamic> prepareWriteJson(Map<String, dynamic> json) {
    return {for (final entry in json.entries) '`${entry.key}`': entry.value};
  }
}
