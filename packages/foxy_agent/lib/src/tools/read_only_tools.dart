import 'package:foxy_agent/src/agent_tool.dart';
import 'package:foxy_agent/src/tools/aggregate_tools.dart';
import 'package:foxy_agent/src/tools/query_sql_tool.dart';
import 'package:foxy_agent/src/tools/read_only_data_source.dart';
import 'package:foxy_agent/src/tools/read_only_tool_input.dart';
import 'package:foxy_agent/src/tools/reference_tools.dart';
import 'package:foxy_agent/src/tools/row_expansion.dart';
import 'package:foxy_agent/src/tools/table_catalog.dart';

/// Combines catalog and server-time tools with the data source's query tools.
/// A [ReadOnlySqlDataSource] exposes `query_sql` over catalog base tables.
///
/// The host app supplies the metadata ([catalog]) and the data access
/// ([dataSource]); tool implementations stay in this package. The catalog may
/// span several databases (see [TableInfo.database]); the data source receives
/// the qualified `database.table` name.
List<AgentTool> createReadOnlyTools({
  required TableCatalog catalog,
  required ReadOnlyDataSource dataSource,
}) {
  final sqlSource = dataSource is ReadOnlySqlDataSource
      ? dataSource as ReadOnlySqlDataSource
      : null;
  final readableCatalog = sqlSource == null
      ? catalog
      : TableCatalog(
          catalog.tables.where((table) => table.isBaseTable).toList(),
        );

  return [
    ListTablesTool(readableCatalog),
    DescribeTableTool(readableCatalog),
    DescribeFieldValuesTool(readableCatalog),
    DescribeReferencesTool(readableCatalog),
    ServerTimeTool(dataSource),
    if (sqlSource != null)
      QuerySqlTool(readableCatalog, sqlSource)
    else ...[
      CountRowsTool(catalog, dataSource),
      AggregateRowsTool(catalog, dataSource),
      QueryRowsTool(catalog, dataSource),
      GetRowTool(catalog, dataSource),
    ],
  ];
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
    final resolved = resolveTable(catalog, arguments['table']);
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
      'primary key. Use the returned column names and keys in queries.';

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
    final resolved = resolveTable(catalog, arguments['table']);
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
      'primary-key columns. Use expand to include referenced names in the '
      'same call. Read-only.';

  @override
  Map<String, Object?> get inputSchema => {
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
      'expand': expansionSchema,
    },
    'required': ['table', 'key'],
    'additionalProperties': false,
  };

  @override
  String get name => 'get_row';

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final resolved = resolveTable(catalog, arguments['table']);
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
    final expansion = RowExpansion.parse(catalog, table, arguments['expand']);
    if (expansion.expansions == null) return expansion.error!;
    final rows = await dataSource.queryRows(
      table: table.qualifiedName,
      filters: filters,
      limit: 1,
    );
    if (rows.isEmpty) {
      return {'found': false};
    }
    final expanded = await RowExpansion.apply(
      dataSource,
      rows,
      expansion.expansions!,
    );
    return {'found': true, 'row': expanded.first};
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
      '$maxLimit rows (default $defaultLimit). Use orderBy on catalog columns '
      'for rankings and nextOffset as offset for subsequent pages. Primary-key '
      'columns break sorting ties when available. Use describe_table to learn '
      'column names. To match any of several values in one call, use the '
      '"in" operator with an array value instead of querying values one by '
      'one. Use expand to include referenced names in the same call. '
      'For exact totals or distributions use count_rows or aggregate_rows.';

  @override
  Map<String, Object?> get inputSchema => {
    'type': 'object',
    'properties': {
      'table': {
        'type': 'string',
        'description': 'Table name from list_tables.',
      },
      'filters': filterSchema,
      'expand': expansionSchema,
      'orderBy': orderBySchema,
      'offset': offsetSchema,
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
    final resolved = resolveTable(catalog, arguments['table']);
    final table = resolved.table;
    if (table == null) {
      return resolved.error!;
    }
    final parsed = parseFilters(table, arguments['filters']);
    if (parsed.filters == null) return parsed.error!;
    final sorting = parseOrderBy(arguments['orderBy'], {
      for (final column in table.columns) column.name,
    });
    if (sorting.orderBy == null) return sorting.error!;
    final offset = arguments['offset'] ?? 0;
    if (offset is! int || offset < 0) {
      return '"offset" must be a non-negative integer.';
    }
    final expansion = RowExpansion.parse(catalog, table, arguments['expand']);
    if (expansion.expansions == null) return expansion.error!;
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
      filters: parsed.filters!,
      limit: limit + 1,
      orderBy: sorting.orderBy!,
      offset: offset,
    );
    final truncated = rows.length > limit;
    final visible = truncated ? rows.take(limit).toList() : rows;
    final expanded = await RowExpansion.apply(
      dataSource,
      visible,
      expansion.expansions!,
    );
    return {
      'count': visible.length,
      'rows': expanded,
      if (truncated) 'truncated': true,
      if (truncated) 'nextOffset': offset + visible.length,
    };
  }
}

/// Gets the time used by the connected database for relative-date queries.
final class ServerTimeTool extends AgentTool {
  final ReadOnlyDataSource dataSource;

  const ServerTimeTool(this.dataSource);

  @override
  String get description =>
      'Read the connected MySQL server clock: localTime, utcTime, '
      'sessionTimeZone, utcOffsetSeconds and unixTimestamp (seconds). '
      'Use before calculating relative date or time filters.';

  @override
  Map<String, Object?> get inputSchema => const {
    'type': 'object',
    'properties': <String, Object?>{},
    'additionalProperties': false,
  };

  @override
  String get name => 'server_time';

  @override
  Future<Object?> call(Map<String, Object?> arguments) =>
      dataSource.serverTime();
}
