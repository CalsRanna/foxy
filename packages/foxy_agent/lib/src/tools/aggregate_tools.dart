import 'package:foxy_agent/src/agent_tool.dart';
import 'package:foxy_agent/src/tools/read_only_data_source.dart';
import 'package:foxy_agent/src/tools/read_only_tool_input.dart';
import 'package:foxy_agent/src/tools/table_catalog.dart';

/// Shared validation for tools and host adapters before constructing SQL.
String? validateAggregation(
  TableInfo table,
  List<String> groupBy,
  List<AggregateMetric> metrics,
) {
  if (groupBy.length > AggregateRowsTool.maxGroupBy ||
      groupBy.toSet().length != groupBy.length) {
    return '"groupBy" accepts at most 3 distinct columns.';
  }
  if (metrics.isEmpty || metrics.length > AggregateRowsTool.maxMetrics) {
    return 'Provide between 1 and 8 metrics.';
  }
  for (final column in groupBy) {
    if (table.findColumn(column) == null) {
      return 'Unknown group column "$column".';
    }
  }
  final names = groupBy.map((name) => name.toLowerCase()).toSet();
  for (final metric in metrics) {
    final column = metric.column == null
        ? null
        : table.findColumn(metric.column!);
    if (metric.column != null && column == null) {
      return 'Unknown metric column "${metric.column}".';
    }
    if (metric.function != AggregateFunction.count &&
        (column == null ||
            (column.type != 'int' && column.type != 'decimal'))) {
      return '${metric.function.name} requires a numeric column.';
    }
    if (!names.add(metric.outputName.toLowerCase())) {
      return 'Duplicate aggregate output name "${metric.outputName}".';
    }
  }
  return null;
}

/// Restricted database aggregation with bounded output, never sampled input.
final class AggregateRowsTool extends AgentTool {
  static const maxLimit = 50;
  static const maxGroupBy = 3;
  static const maxMetrics = 8;

  final TableCatalog catalog;
  final ReadOnlyDataSource dataSource;

  const AggregateRowsTool(this.catalog, this.dataSource);

  @override
  String get description =>
      'Aggregate ALL matching rows in the database with count/sum/avg/min/max, '
      'optionally grouped by up to 3 columns. Only returned groups are limited '
      '(default/max 50); truncated means some groups are omitted, never that '
      'input rows were sampled. Results use function_column keys, or count '
      'for COUNT(*). COUNT(column) excludes nulls; other functions need numeric '
      'columns and ignore nulls (null when no values). Use orderBy with group '
      'columns or metric output names for rankings. Group columns break ties. '
      'Use nextOffset as offset to continue. Use count_rows with the same '
      'filters for proportions.';

  @override
  Map<String, Object?> get inputSchema => const {
    'type': 'object',
    'properties': {
      'table': {'type': 'string'},
      'filters': filterSchema,
      'groupBy': {
        'type': 'array',
        'items': {'type': 'string'},
        'maxItems': maxGroupBy,
        'uniqueItems': true,
      },
      'metrics': {
        'type': 'array',
        'minItems': 1,
        'maxItems': maxMetrics,
        'items': {
          'type': 'object',
          'properties': {
            'function': {
              'type': 'string',
              'enum': ['count', 'sum', 'avg', 'min', 'max'],
            },
            'column': {
              'type': 'string',
              'description': 'Catalog column. Omit only for COUNT(*).',
            },
          },
          'required': ['function'],
          'additionalProperties': false,
        },
      },
      'limit': {'type': 'integer', 'minimum': 1, 'maximum': maxLimit},
      'orderBy': orderBySchema,
      'offset': offsetSchema,
    },
    'required': ['table', 'metrics'],
    'additionalProperties': false,
  };

  @override
  String get name => 'aggregate_rows';

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final resolved = resolveTable(catalog, arguments['table']);
    final table = resolved.table;
    if (table == null) return resolved.error!;
    final parsed = parseFilters(table, arguments['filters']);
    if (parsed.filters == null) return parsed.error!;
    final rawGroups = arguments['groupBy'] ?? const <Object?>[];
    if (rawGroups is! List<Object?> ||
        rawGroups.any((item) => item is! String)) {
      return '"groupBy" must be an array of column names.';
    }
    final groups = rawGroups.cast<String>();
    final rawMetrics = arguments['metrics'];
    if (rawMetrics is! List<Object?>) return '"metrics" must be an array.';
    final metrics = <AggregateMetric>[];
    for (final raw in rawMetrics) {
      if (raw is! Map<String, Object?>) return 'Each metric must be an object.';
      final function = AggregateFunction.values.where(
        (function) => function.name == raw['function'],
      );
      if (function.isEmpty) {
        return 'Unknown aggregate function "${raw['function']}".';
      }
      final column = raw['column'];
      if (column != null && column is! String) {
        return 'Metric "column" must be a string.';
      }
      metrics.add(
        AggregateMetric(function: function.first, column: column as String?),
      );
    }
    final error = validateAggregation(table, groups, metrics);
    if (error != null) return error;
    final sorting = parseOrderBy(arguments['orderBy'], {
      ...groups,
      for (final metric in metrics) metric.outputName,
    });
    if (sorting.orderBy == null) return sorting.error!;
    final offset = arguments['offset'] ?? 0;
    if (offset is! int || offset < 0) {
      return '"offset" must be a non-negative integer.';
    }
    final rawLimit = arguments['limit'];
    if (rawLimit != null && rawLimit is! int) {
      return '"limit" must be an integer.';
    }
    final limit = ((rawLimit as int?) ?? maxLimit).clamp(1, maxLimit);
    final rows = await dataSource.aggregateRows(
      table: table.qualifiedName,
      filters: parsed.filters!,
      groupBy: groups,
      metrics: metrics,
      limit: limit + 1,
      orderBy: sorting.orderBy!,
      offset: offset,
    );
    final visible = rows.take(limit).toList();
    final truncated = rows.length > limit;
    return {
      'table': table.qualifiedName,
      'count': visible.length,
      'rows': visible,
      if (truncated) 'truncated': true,
      if (truncated) 'nextOffset': offset + visible.length,
    };
  }
}

/// Counts all matching rows, without fetching a sample.
final class CountRowsTool extends AgentTool {
  final TableCatalog catalog;
  final ReadOnlyDataSource dataSource;

  const CountRowsTool(this.catalog, this.dataSource);

  @override
  String get description =>
      'Count every matching row in a table using database COUNT(*). '
      'Filters combine with AND. The result is exact, with no row limit. '
      'Use this for totals and denominators instead of counting query_rows.';

  @override
  Map<String, Object?> get inputSchema => const {
    'type': 'object',
    'properties': {
      'table': {'type': 'string'},
      'filters': filterSchema,
    },
    'required': ['table'],
    'additionalProperties': false,
  };

  @override
  String get name => 'count_rows';

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    final resolved = resolveTable(catalog, arguments['table']);
    final table = resolved.table;
    if (table == null) return resolved.error!;
    final parsed = parseFilters(table, arguments['filters']);
    if (parsed.filters == null) return parsed.error!;
    final count = await dataSource.countRows(
      table: table.qualifiedName,
      filters: parsed.filters!,
    );
    return {'table': table.qualifiedName, 'count': count};
  }
}
