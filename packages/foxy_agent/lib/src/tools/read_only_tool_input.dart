import 'package:foxy_agent/src/tools/table_catalog.dart';

/// Resolves the `table` argument of a tool call to a catalog entry.
({TableInfo? table, String? error}) resolveTable(
  TableCatalog catalog,
  Object? rawName,
) {
  if (rawName is! String || rawName.isEmpty) {
    return (
      table: null,
      error:
          'Missing "table" argument. Call list_tables to see the '
          'available tables.',
    );
  }
  final table = catalog.find(rawName);
  if (table != null) {
    return (table: table, error: null);
  }
  if (catalog.tables.any((candidate) => candidate.name == rawName)) {
    return (
      table: null,
      error:
          'Ambiguous table name "$rawName"; use the qualified name '
          '(database.table) returned by list_tables.',
    );
  }
  return (
    table: null,
    error:
        'Unknown table "$rawName". Call list_tables to see the available '
        'tables.',
  );
}
