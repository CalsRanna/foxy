import 'package:foxy/constant/dbc_definitions.dart';
import 'package:foxy/model/dbc/dbc_export_table.dart';
import 'package:foxy/repository/dbc_export_registry.dart';

/// Shared helpers for the standalone and combined DBC export use cases.
abstract final class DbcExportShared {
  /// Tables counted per batch in [loadDbcExportTables]. Each table costs one
  /// COUNT round-trip, so they run in bounded batches instead of one at a
  /// time: 66 tables would otherwise serialize 66 remote round-trips.
  static const int countBatchSize = 8;

  /// Loads the row-count view of every DBC table for the export-selection
  /// dialog. Shared by the standalone, combined and MPQ export use cases.
  ///
  /// Counts run in bounded batches; each table's success or failure is kept
  /// per row, so a failing table only disables itself.
  static Future<List<DbcExportTable>> loadDbcExportTables(
    DbcExportRegistry registry,
  ) async {
    final definitions = DbcDefinitions.all;
    final tables = <DbcExportTable>[];
    for (var start = 0; start < definitions.length; start += countBatchSize) {
      final end = start + countBatchSize;
      final batch = definitions.sublist(
        start,
        end < definitions.length ? end : definitions.length,
      );
      tables.addAll(
        await Future.wait(
          batch.map((definition) async {
            final result = await registry.countRows(definition.tableName);
            return DbcExportTable(
              definition: definition,
              recordCount: result.count,
              countError: result.error,
            );
          }),
        ),
      );
    }
    tables.sort(
      (left, right) =>
          left.definition.fileName.compareTo(right.definition.fileName),
    );
    return tables;
  }
}
