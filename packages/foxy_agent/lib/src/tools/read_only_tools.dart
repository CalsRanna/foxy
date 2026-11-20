import 'package:foxy_agent/src/agent_tool.dart';
import 'package:foxy_agent/src/tools/read_only_data_source.dart';
import 'package:foxy_agent/src/tools/table_catalog.dart';

/// The built-in read-only toolset: `list_tables`, `describe_table`,
/// `query_rows` and `get_row`.
///
/// The host app supplies the metadata ([catalog]) and the data access
/// ([dataSource]); tool implementations stay in this package. The catalog may
/// span several databases (see [TableInfo.database]); the data source receives
/// the qualified `database.table` name.
List<AgentTool> createReadOnlyTools({
  required TableCatalog catalog,
  required ReadOnlyDataSource dataSource,
}) => [
  ListTablesTool(catalog),
  DescribeTableTool(catalog),
  DescribeFieldValuesTool(catalog),
  QueryRowsTool(catalog, dataSource),
  GetRowTool(catalog, dataSource),
];

/// Resolves the `table` argument of a tool call to a catalog entry.
({TableInfo? table, String? error}) _resolveTable(
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

/// Explains the full meaning of one column's values.
final class DescribeFieldValuesTool extends AgentTool {
  final TableCatalog catalog;

  const DescribeFieldValuesTool(this.catalog);

  @override
  String get description =>
      'Explain what a column\'s values mean: enum value labels, bit flags, or '
      'the referenced table/column. Columns with a semantics summary in '
      'describe_table should be explained through this tool before drawing '
      'conclusions; never guess the meaning of an undefined value.';

  @override
  Map<String, Object?> get inputSchema => const {
    'type': 'object',
    'properties': {
      'table': {
        'type': 'string',
        'description': 'Table name from list_tables.',
      },
      'column': {
        'type': 'string',
        'description': 'Column name from describe_table.',
      },
    },
    'required': ['table', 'column'],
    'additionalProperties': false,
  };

  @override
  String get name => 'describe_field_values';

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final resolved = _resolveTable(catalog, arguments['table']);
    final table = resolved.table;
    if (table == null) {
      return resolved.error!;
    }
    final columnName = arguments['column'];
    if (columnName is! String || columnName.isEmpty) {
      return 'Missing "column" argument. Use describe_table to see the '
          'available columns.';
    }
    final column = table.findColumn(columnName);
    if (column == null) {
      return 'Unknown column "$columnName" on table '
          '"${table.qualifiedName}".';
    }
    final semantics = column.semantics;
    if (semantics == null) {
      return 'No semantic definition is available for "$columnName" on table '
          '"${table.qualifiedName}". Do not guess its meaning.';
    }
    return {
      'table': table.qualifiedName,
      'column': columnName,
      'semantics': semantics.toJson(),
    };
  }
}

/// Describes one table: columns, types, labels and primary key.
final class DescribeTableTool extends AgentTool {
  final TableCatalog catalog;

  const DescribeTableTool(this.catalog);

  @override
  String get description =>
      'Describe one table: its columns, their types and meanings, and the '
      'primary key. Use the returned column names in query_rows filters and '
      'get_row keys.';

  @override
  Map<String, Object?> get inputSchema => const {
    'type': 'object',
    'properties': {
      'table': {
        'type': 'string',
        'description': 'Table name from list_tables.',
      },
    },
    'required': ['table'],
    'additionalProperties': false,
  };

  @override
  String get name => 'describe_table';

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final resolved = _resolveTable(catalog, arguments['table']);
    final table = resolved.table;
    if (table == null) {
      return resolved.error!;
    }
    return {'table': table.toJson()};
  }
}

/// Reads a single row by primary key.
final class GetRowTool extends AgentTool {
  final TableCatalog catalog;

  final ReadOnlyDataSource dataSource;

  const GetRowTool(this.catalog, this.dataSource);

  @override
  String get description =>
      'Read one row by primary key. Use describe_table to learn the '
      'primary-key columns. Read-only.';

  @override
  Map<String, Object?> get inputSchema => const {
    'type': 'object',
    'properties': {
      'table': {
        'type': 'string',
        'description': 'Table name from list_tables.',
      },
      'key': {
        'type': 'object',
        'description': 'Primary-key column to value map, e.g. {"entry": 1234}.',
        'additionalProperties': true,
      },
    },
    'required': ['table', 'key'],
    'additionalProperties': false,
  };

  @override
  String get name => 'get_row';

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final resolved = _resolveTable(catalog, arguments['table']);
    final table = resolved.table;
    if (table == null) {
      return resolved.error!;
    }
    final key = arguments['key'];
    if (key is! Map<String, Object?> || key.isEmpty) {
      return 'Missing "key" argument: an object mapping primary-key columns '
          'to values.';
    }
    final primaryKey = table.primaryKey.toList();
    if (primaryKey.isNotEmpty) {
      final expected = {for (final column in primaryKey) column.name};
      final missing = expected.difference(key.keys.toSet());
      if (missing.isNotEmpty) {
        return 'Missing primary-key column(s) ${missing.join(', ')} on '
            'table "${table.qualifiedName}".';
      }
    }
    final filters = <RowFilter>[];
    for (final entry in key.entries) {
      if (table.findColumn(entry.key) == null) {
        return 'Unknown column "${entry.key}" on table '
            '"${table.qualifiedName}".';
      }
      filters.add(
        RowFilter(
          column: entry.key,
          operator: FilterOperator.equals,
          value: entry.value,
        ),
      );
    }
    final rows = await dataSource.queryRows(
      table: table.qualifiedName,
      filters: filters,
      limit: 1,
    );
    if (rows.isEmpty) {
      return {'found': false};
    }
    return {'found': true, 'row': rows.first};
  }
}

/// Lists the tables the agent may read.
final class ListTablesTool extends AgentTool {
  final TableCatalog catalog;

  const ListTablesTool(this.catalog);

  @override
  String get description =>
      'List the database tables this agent can read. Call this first to '
      'discover table names and their meanings. Optionally filter by a search '
      'term matched against table names, database names and labels.';

  @override
  Map<String, Object?> get inputSchema => const {
    'type': 'object',
    'properties': {
      'query': {
        'type': 'string',
        'description':
            'Optional case-insensitive substring matched against table '
            'names, database names or labels.',
      },
    },
    'additionalProperties': false,
  };

  @override
  String get name => 'list_tables';

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final query = arguments['query'];
    final needle = query is String ? query.trim().toLowerCase() : '';
    final tables = [
      for (final table in catalog.tables)
        if (needle.isEmpty ||
            table.name.toLowerCase().contains(needle) ||
            table.database.toLowerCase().contains(needle) ||
            table.label.toLowerCase().contains(needle))
          {
            'name': table.qualifiedName,
            if (table.database.isNotEmpty) 'database': table.database,
            if (table.label.isNotEmpty) 'label': table.label,
          },
    ];
    return {'tables': tables, 'count': tables.length};
  }
}

/// Reads rows from a table with optional column filters.
final class QueryRowsTool extends AgentTool {
  /// Hard cap on rows returned in one call.
  static const int maxLimit = 50;

  /// Default row limit when the model does not provide one.
  static const int defaultLimit = 20;

  final TableCatalog catalog;

  final ReadOnlyDataSource dataSource;

  const QueryRowsTool(this.catalog, this.dataSource);

  @override
  String get description =>
      'Read rows from a table. Filters combine with AND. Returns at most '
      '$maxLimit rows (default $defaultLimit); narrow with filters when the '
      'table is large. Read-only. Use describe_table to learn column names '
      'before filtering. To match any of several values in one call, use the '
      '"in" operator with an array value instead of querying values one by '
      'one.';

  @override
  Map<String, Object?> get inputSchema => const {
    'type': 'object',
    'properties': {
      'table': {
        'type': 'string',
        'description': 'Table name from list_tables.',
      },
      'filters': {
        'type': 'array',
        'description': 'All filters must match (logical AND).',
        'items': {
          'type': 'object',
          'properties': {
            'column': {'type': 'string', 'description': 'Column name.'},
            'operator': {
              'type': 'string',
              'enum': [
                'equals',
                'notEquals',
                'contains',
                'in',
                'greaterThan',
                'greaterOrEqual',
                'lessThan',
                'lessOrEqual',
              ],
            },
            'value': {
              'type': [
                'string',
                'number',
                'integer',
                'boolean',
                'null',
                'array',
              ],
              'description':
                  'Scalar value to compare against, or a non-empty array '
                  'when the operator is "in".',
            },
          },
          'required': ['column', 'operator', 'value'],
          'additionalProperties': false,
        },
      },
      'limit': {
        'type': 'integer',
        'minimum': 1,
        'maximum': maxLimit,
        'description': 'Maximum rows to return. Defaults to $defaultLimit.',
      },
    },
    'required': ['table'],
    'additionalProperties': false,
  };

  @override
  String get name => 'query_rows';

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final resolved = _resolveTable(catalog, arguments['table']);
    final table = resolved.table;
    if (table == null) {
      return resolved.error!;
    }
    final filters = <RowFilter>[];
    final rawFilters = arguments['filters'];
    if (rawFilters != null) {
      if (rawFilters is! List<Object?>) {
        return '"filters" must be an array of filter objects.';
      }
      for (final rawFilter in rawFilters) {
        if (rawFilter is! Map<String, Object?>) {
          return 'Each filter must be an object with "column", "operator" '
              'and "value".';
        }
        final column = rawFilter['column'];
        if (column is! String || table.findColumn(column) == null) {
          return 'Unknown column "${column ?? ''}" on table '
              '"${table.qualifiedName}".';
        }
        final operatorName = rawFilter['operator'];
        final operator = operatorName is String
            ? FilterOperator.tryParse(operatorName)
            : null;
        if (operator == null) {
          return 'Unknown filter operator "$operatorName" on table '
              '"${table.qualifiedName}". Supported: '
              '${FilterOperator.values.map((item) => item.wireName).join(', ')}.';
        }
        final value = rawFilter['value'];
        if (operator == FilterOperator.inList) {
          if (value is! List<Object?> || value.isEmpty) {
            return 'The "in" operator requires a non-empty array as "value" '
                'on table "${table.qualifiedName}".';
          }
        } else if (value is List<Object?> || value is Map<String, Object?>) {
          return 'The "value" for operator "${operator.wireName}" must be a '
              'scalar on table "${table.qualifiedName}".';
        }
        filters.add(
          RowFilter(column: column, operator: operator, value: value),
        );
      }
    }
    var limit = defaultLimit;
    final rawLimit = arguments['limit'];
    if (rawLimit is num) {
      final value = rawLimit.toInt();
      if (value < 1) {
        limit = 1;
      } else if (value > maxLimit) {
        limit = maxLimit;
      } else {
        limit = value;
      }
    }
    // Ask for one extra row to detect truncation.
    final rows = await dataSource.queryRows(
      table: table.qualifiedName,
      filters: filters,
      limit: limit + 1,
    );
    final truncated = rows.length > limit;
    final visible = truncated ? rows.take(limit).toList() : rows;
    return {
      'count': visible.length,
      'rows': visible,
      if (truncated) 'truncated': true,
    };
  }
}
