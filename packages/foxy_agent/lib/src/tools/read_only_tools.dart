import 'package:foxy_agent/src/agent_tool.dart';
import 'package:foxy_agent/src/tools/column_semantics.dart';
import 'package:foxy_agent/src/tools/query_sql_tool.dart';
import 'package:foxy_agent/src/tools/read_only_data_source.dart';
import 'package:foxy_agent/src/tools/read_only_tool_input.dart';
import 'package:foxy_agent/src/tools/reference_tools.dart';
import 'package:foxy_agent/src/tools/table_catalog.dart';

/// Combines catalog and server-time tools with the data source's query tool.
/// The data source executes `query_sql` over catalog base tables.
///
/// The host app supplies the metadata ([catalog]) and the data access
/// ([dataSource]); tool implementations stay in this package. The catalog may
/// span several databases (see [TableInfo.database]); the data source receives
/// the qualified `database.table` name.
List<AgentTool> createReadOnlyTools({
  required TableCatalog catalog,
  required ReadOnlyDataSource dataSource,
}) {
  final readableCatalog = TableCatalog(
    catalog.tables.where((table) => table.isBaseTable).toList(),
  );

  return [
    ListTablesTool(readableCatalog),
    DescribeTableTool(readableCatalog),
    DescribeFieldValuesTool(readableCatalog),
    DescribeReferencesTool(readableCatalog),
    ServerTimeTool(dataSource),
    QuerySqlTool(readableCatalog, dataSource),
  ];
}

/// Explains the full meaning of one column's values.
final class DescribeFieldValuesTool extends AgentTool {
  final TableCatalog catalog;

  const DescribeFieldValuesTool(this.catalog);

  @override
  String get description =>
      'Explain a column\'s enum values, bit flags, references, or conditional '
      'meanings. For a conditional column, omit context to discover branches '
      'before querying. Use every branch condition when filtering or joining. '
      'Supply context to explain one row or inspect a specific branch.';

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
      'context': {
        'type': 'object',
        'description':
            'Known physical column values for a conditional field. Include '
            'the dependency columns and, if available, the value to explain.',
        'additionalProperties': true,
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
    final rawContext = arguments['context'];
    if (rawContext != null && rawContext is! Map<String, Object?>) {
      return '"context" must be an object keyed by column name.';
    }
    final context = rawContext as Map<String, Object?>?;
    if (semantics.kind == ColumnSemanticKind.conditional && context != null) {
      for (final name in semantics.dependsOn) {
        if (!context.containsKey(name)) continue;
        final value = context[name];
        if (value is! num ||
            !value.isFinite ||
            value != value.truncateToDouble()) {
          return 'Context column "$name" must be an integer.';
        }
      }
    }
    return {
      'table': table.qualifiedName,
      'column': columnName,
      'semantics':
          semantics.kind == ColumnSemanticKind.conditional && context != null
          ? semantics.describeForRow(columnName, context)
          : semantics.toJson(),
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
