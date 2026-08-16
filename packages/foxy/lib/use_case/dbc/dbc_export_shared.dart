import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/dbc/dbc_export_registry.dart';
import 'package:foxy/use_case/dbc/export_dbc_use_case.dart';
import 'package:laconic_mysql/laconic_mysql.dart';

/// Shared helpers for the standalone and combined DBC export use cases.
abstract final class DbcExportShared {
  /// Loads the row-count view of every DBC table for the export-selection
  /// dialog. Shared by the standalone and combined export use cases.
  static Future<List<DbcExportTable>> loadDbcExportTables(
    DbcExportRegistry registry,
  ) async {
    final tables = <DbcExportTable>[];
    for (final definition in DbcDefinitions.all) {
      final result = await registry.countRows(definition.tableName);
      tables.add(
        DbcExportTable(
          definition: definition,
          recordCount: result.count,
          countError: result.error,
        ),
      );
    }
    tables.sort(
      (left, right) =>
          left.definition.fileName.compareTo(right.definition.fileName),
    );
    return tables;
  }

  /// Builds the MySQL config from the saved config.yaml (same defaults as the
  /// bootstrap wizard). Shared by the standalone and combined export use cases.
  static Future<MysqlConfig> mysqlConfigFromSaved(ConfigUtil configUtil) async {
    final config = await configUtil.load();
    return MysqlConfig(
      host: config['host']?.toString() ?? '127.0.0.1',
      port: parseMysqlPort(config['port']),
      database: config['database']?.toString() ?? 'acore_world',
      username: config['username']?.toString() ?? 'acore',
      password: config['password']?.toString() ?? 'acore',
      useSsl: config['use_ssl'] == true,
      allowPublicKeyRetrieval: config['use_ssl'] != true,
    );
  }

  static int parseMysqlPort(Object? value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 3306;
  }
}
