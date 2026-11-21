import 'package:foxy_agent/src/agent_tool.dart';
import 'package:foxy_agent/src/tools/read_only_sql.dart';
import 'package:foxy_agent/src/tools/table_catalog.dart';

/// Executes a validated MySQL SELECT using the host app's data connection.
abstract interface class ReadOnlySqlDataSource {
  Future<List<Map<String, Object?>>> querySql(ReadOnlySql sql);
}

/// Reads the optimizer plan and table statistics for a validated SELECT.
abstract interface class SqlDiagnosticsDataSource {
  Future<Map<String, Object?>> explainSql(ReadOnlySql sql);
}

const _sqlInputSchema = <String, Object?>{
  'type': 'object',
  'properties': {
    'sql': {
      'type': 'string',
      'description': 'One MySQL SELECT statement with no SQL comments.',
    },
  },
  'required': ['sql'],
  'additionalProperties': false,
};

final class QuerySqlTool extends AgentTool {
  final TableCatalog catalog;
  final ReadOnlySqlDataSource dataSource;

  const QuerySqlTool(this.catalog, this.dataSource);

  @override
  String get name => 'query_sql';

  @override
  String get description =>
      'Run one read-only MySQL SELECT on catalog base tables with explicit columns. Use '
      'this for joins, filtering or ordering by related columns, or '
      'aggregation in one query. Use exact table names from list_tables '
      '(including any schema prefix) and columns from describe_table. '
      'Qualify columns in joins and use AS for result aliases. Supports '
      'JOIN ... ON, WHERE, CASE, GROUP BY, HAVING, ORDER BY and LIMIT. '
      'COUNT(*) is allowed; wildcard projections, subqueries, CTEs and '
      'SQL comments are unsupported. Defaults to ${ReadOnlySql.defaultRows} rows. '
      'An explicit LIMIT can request up to ${ReadOnlySql.maxRows} rows per page.';

  @override
  Map<String, Object?> get inputSchema => _sqlInputSchema;

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final (query, error) = _validateSql(arguments, catalog);
    if (query == null) return error;

    final timer = Stopwatch()..start();
    final rows = await dataSource.querySql(query);
    timer.stop();
    final truncated = rows.length > query.rowLimit;
    return {
      'rows': truncated ? rows.take(query.rowLimit).toList() : rows,
      'truncated': truncated,
      'elapsedMs': timer.elapsedMicroseconds / 1000,
    };
  }
}

final class ExplainSqlTool extends AgentTool {
  final TableCatalog catalog;
  final SqlDiagnosticsDataSource dataSource;

  const ExplainSqlTool(this.catalog, this.dataSource);

  @override
  String get name => 'explain_sql';

  @override
  String get description =>
      'Explain a SELECT using the same catalog and row limit as query_sql. '
      'Returns estimated MySQL execution cost, row scans, candidate and chosen '
      'indexes, plus table sizes, estimated row counts and index definitions. '
      'Use to diagnose slow queries or check whether a filter uses an index. '
      'Provide the SELECT itself; the tool obtains the plan without running '
      'the SELECT for results.';

  @override
  Map<String, Object?> get inputSchema => _sqlInputSchema;

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final (query, error) = _validateSql(arguments, catalog);
    if (query == null) return error;
    return dataSource.explainSql(query);
  }
}

(ReadOnlySql?, String?) _validateSql(
  Map<String, Object?> arguments,
  TableCatalog catalog,
) {
  final sql = arguments['sql'];
  if (sql is! String) {
    return (null, 'Provide "sql" as one MySQL SELECT statement.');
  }
  try {
    return (ReadOnlySql.parse(sql, catalog), null);
  } on FormatException catch (error) {
    return (null, 'SQL rejected: ${error.message}');
  }
}
