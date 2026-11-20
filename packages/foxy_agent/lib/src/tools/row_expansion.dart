import 'package:foxy_agent/src/tools/read_only_data_source.dart';
import 'package:foxy_agent/src/tools/read_only_tool_input.dart';
import 'package:foxy_agent/src/tools/table_catalog.dart';

const _maxDepth = 3;
const _maxExpansions = 5;

final expansionSchema = _expansionSchema(_maxDepth);

Map<String, Object?> _expansionSchema(int remainingDepth) => {
  'type': 'array',
  'maxItems': _maxExpansions,
  'description':
      'Expand declared references up to $_maxDepth hops and $_maxExpansions '
      'total references. Each row keeps its original '
      'columns and adds _expanded: {sourceColumn: targetRow or null}. '
      'Use describe_references for available paths and describe_table for '
      'target columns. The target primary key and nested reference IDs are '
      'included automatically.',
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
      if (remainingDepth > 1) 'expand': _expansionSchema(remainingDepth - 1),
    },
    'required': ['column', 'columns'],
    'additionalProperties': false,
  },
};

/// A validated expansion to a unique catalog key, with optional next hops.
final class RowExpansion {
  final String column;
  final TableInfo target;
  final String key;
  final List<String> columns;
  final List<RowExpansion> children;

  const RowExpansion(
    this.column,
    this.target,
    this.key,
    this.columns,
    this.children,
  );

  int get _size => 1 + children.fold(0, (size, child) => size + child._size);

  static ({List<RowExpansion>? expansions, String? error}) parse(
    TableCatalog catalog,
    TableInfo table,
    Object? raw, {
    int depth = 1,
  }) {
    if (raw == null) return (expansions: const [], error: null);
    if (raw is! List<Object?> || raw.length > _maxExpansions) {
      return (
        expansions: null,
        error:
            '"expand" must be an array of at most $_maxExpansions references.',
      );
    }
    if (raw.isNotEmpty && depth > _maxDepth) {
      return (
        expansions: null,
        error: '"expand" supports at most $_maxDepth hops.',
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
      if (!target.hasSingleColumnPrimaryKey(reference.column)) {
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
      final nested = parse(catalog, target, item['expand'], depth: depth + 1);
      if (nested.expansions == null) return nested;
      expansions.add(
        RowExpansion(
          column,
          target,
          reference.column,
          columns.cast<String>(),
          nested.expansions!,
        ),
      );
    }
    if (expansions.fold(0, (size, expansion) => size + expansion._size) >
        _maxExpansions) {
      return (
        expansions: null,
        error: '"expand" accepts at most $_maxExpansions references in total.',
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
      final nested = await apply(source, targets, expansion.children);
      final byKey = {
        for (final target in nested) target[expansion.key]: target,
      };
      final columns = {
        expansion.key,
        ...expansion.columns,
        for (final child in expansion.children) child.column,
      };
      for (var i = 0; i < rows.length; i++) {
        final target = byKey[rows[i][expansion.column]];
        final references = expanded[i]['_expanded']! as Map<String, Object?>;
        references[expansion.column] = target == null
            ? null
            : {
                for (final column in columns) column: target[column],
                if (expansion.children.isNotEmpty)
                  '_expanded': target['_expanded'],
              };
      }
    }
    return expanded;
  }
}
