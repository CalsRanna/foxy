import 'package:foxy_agent/src/tools/read_only_data_source.dart';
import 'package:foxy_agent/src/tools/read_only_tool_input.dart';
import 'package:foxy_agent/src/tools/table_catalog.dart';

const expansionSchema = {
  'type': 'array',
  'maxItems': 5,
  'description':
      'Expand declared references in one hop. Each row keeps its original '
      'columns and adds _expanded: {sourceColumn: targetRow or null}. '
      'Use target columns from describe_table (e.g. name or Title); '
      'the target primary key is included automatically.',
  'items': {
    'type': 'object',
    'properties': {
      'column': {'type': 'string', 'description': 'Source reference column.'},
      'columns': {
        'type': 'array',
        'items': {'type': 'string'},
        'minItems': 1,
        'maxItems': 5,
        'uniqueItems': true,
        'description': 'Columns to return from the referenced table.',
      },
    },
    'required': ['column', 'columns'],
    'additionalProperties': false,
  },
};

/// A validated one-hop expansion to a unique catalog key.
final class RowExpansion {
  final String column;
  final TableInfo target;
  final String key;
  final List<String> columns;

  const RowExpansion(this.column, this.target, this.key, this.columns);

  static ({List<RowExpansion>? expansions, String? error}) parse(
    TableCatalog catalog,
    TableInfo table,
    Object? raw,
  ) {
    if (raw == null) return (expansions: const [], error: null);
    if (raw is! List<Object?> || raw.length > 5) {
      return (
        expansions: null,
        error: '"expand" must be an array of at most 5 references.',
      );
    }
    if (raw.isNotEmpty && table.findColumn('_expanded') != null) {
      return (
        expansions: null,
        error: 'Cannot expand a table with a physical "_expanded" column.',
      );
    }
    final expansions = <RowExpansion>[];
    final seen = <String>{};
    for (final item in raw) {
      if (item is! Map<String, Object?>) {
        return (expansions: null, error: 'Each expansion must be an object.');
      }
      final column = item['column'];
      final reference = column is String
          ? table.findColumn(column)?.semantics?.reference
          : null;
      if (reference == null) {
        return (
          expansions: null,
          error: 'Column "$column" has no declared reference.',
        );
      }
      if (!seen.add(column as String)) {
        return (expansions: null, error: 'Duplicate expansion for "$column".');
      }
      final resolved = resolveTable(catalog, reference.table);
      final target = resolved.table;
      if (target == null) return (expansions: null, error: resolved.error!);
      final keys = target.primaryKey.toList();
      if (keys.length != 1 || keys.single.name != reference.column) {
        return (
          expansions: null,
          error:
              'Reference "$column" must target a single-column primary key; query the target table for one-to-many references.',
        );
      }
      final columns = item['columns'];
      if (columns is! List<Object?> ||
          columns.isEmpty ||
          columns.length > 5 ||
          columns.any(
            (name) => name is! String || target.findColumn(name) == null,
          )) {
        return (
          expansions: null,
          error:
              'Expansion "columns" must contain 1 to 5 catalog columns on "${target.qualifiedName}".',
        );
      }
      expansions.add(
        RowExpansion(column, target, reference.column, columns.cast<String>()),
      );
    }
    return (expansions: expansions, error: null);
  }

  /// Batches all visible keys into one query per expansion, never per row.
  static Future<List<Map<String, Object?>>> apply(
    ReadOnlyDataSource source,
    List<Map<String, Object?>> rows,
    List<RowExpansion> expansions,
  ) async {
    if (expansions.isEmpty || rows.isEmpty) return rows;
    final expanded = rows
        .map(
          (row) => <String, Object?>{...row, '_expanded': <String, Object?>{}},
        )
        .toList();
    for (final expansion in expansions) {
      final values = rows
          .map((row) => row[expansion.column])
          .where((value) => value != null)
          .toSet()
          .toList();
      final targets = values.isEmpty
          ? <Map<String, Object?>>[]
          : await source.queryRows(
              table: expansion.target.qualifiedName,
              filters: [
                RowFilter(
                  column: expansion.key,
                  operator: FilterOperator.inList,
                  value: values,
                ),
              ],
              limit: values.length,
            );
      final byKey = {
        for (final target in targets) target[expansion.key]: target,
      };
      for (var i = 0; i < rows.length; i++) {
        final target = byKey[rows[i][expansion.column]];
        final references = expanded[i]['_expanded']! as Map<String, Object?>;
        references[expansion.column] = target == null
            ? null
            : {
                for (final column in {expansion.key, ...expansion.columns})
                  column: target[column],
              };
      }
    }
    return expanded;
  }
}
