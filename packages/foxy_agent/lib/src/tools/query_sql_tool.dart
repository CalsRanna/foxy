import 'package:foxy_agent/src/agent_tool.dart';
import 'package:foxy_agent/src/tools/read_only_data_source.dart';
import 'package:foxy_agent/src/tools/read_only_sql.dart';
import 'package:foxy_agent/src/tools/table_catalog.dart';

final class QuerySqlTool extends AgentTool {
  final TableCatalog catalog;
  final ReadOnlyDataSource dataSource;

  const QuerySqlTool(this.catalog, this.dataSource);

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
  Map<String, Object?> get inputSchema => const {
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

  @override
  String get name => 'query_sql';

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final sql = arguments['sql'];
    if (sql is! String) {
      return 'Provide "sql" as one MySQL SELECT statement.';
    }
    final ReadOnlySql query;
    try {
      query = ReadOnlySql.parse(sql, catalog);
    } on FormatException catch (error) {
      return 'SQL rejected: ${error.message}';
    }

    final rows = await dataSource.querySql(query);
    final truncated = rows.length > query.rowLimit;
    return {
      'rows': truncated ? rows.take(query.rowLimit).toList() : rows,
      'truncated': truncated,
    };
  }
}
