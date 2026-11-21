import 'package:foxy_agent/src/tools/read_only_data_source.dart';
import 'package:foxy_agent/src/tools/table_catalog.dart';

const filterSchema = {
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
        'type': ['string', 'number', 'integer', 'boolean', 'null', 'array'],
        'description':
            'Scalar value to compare against, or a non-empty array '
            'when the operator is "in".',
      },
    },
    'required': ['column', 'operator', 'value'],
    'additionalProperties': false,
  },
};

const offsetSchema = {
  'type': 'integer',
  'minimum': 0,
  'description':
      'Rows or groups to skip. Defaults to zero. Use nextOffset to continue.',
};

const orderBySchema = {
  'type': 'array',
  'items': {
    'type': 'object',
    'properties': {
      'column': {'type': 'string'},
      'direction': {
        'type': 'string',
        'enum': ['asc', 'desc'],
      },
    },
    'required': ['column', 'direction'],
    'additionalProperties': false,
  },
};

({List<RowFilter>? filters, String? error}) parseFilters(
  TableInfo table,
  Object? rawFilters,
) {
  final filters = <RowFilter>[];
  if (rawFilters != null) {
    if (rawFilters is! List<Object?>) {
      return (
        filters: null,
        error: '"filters" must be an array of filter objects.',
      );
    }
    for (final rawFilter in rawFilters) {
      if (rawFilter is! Map<String, Object?>) {
        return (
          filters: null,
          error:
              'Each filter must be an object with "column", "operator" '
              'and "value".',
        );
      }
      if (!rawFilter.containsKey('value')) {
        return (filters: null, error: 'Missing filter "value".');
      }
      final column = rawFilter['column'];
      if (column is! String || table.findColumn(column) == null) {
        return (
          filters: null,
          error:
              'Unknown column "${column ?? ''}" on table '
              '"${table.qualifiedName}".',
        );
      }
      final operatorName = rawFilter['operator'];
      final operator = operatorName is String
          ? FilterOperator.tryParse(operatorName)
          : null;
      if (operator == null) {
        return (
          filters: null,
          error:
              'Unknown filter operator "$operatorName" on table '
              '"${table.qualifiedName}". Supported: '
              '${FilterOperator.values.map((item) => item.wireName).join(', ')}.',
        );
      }
      final value = rawFilter['value'];
      if (operator == FilterOperator.inList) {
        if (value is! List<Object?> || value.isEmpty) {
          return (
            filters: null,
            error:
                'The "in" operator requires a non-empty array as "value" '
                'on table "${table.qualifiedName}".',
          );
        }
      } else if (value is List<Object?> || value is Map<String, Object?>) {
        return (
          filters: null,
          error:
              'The "value" for operator "${operator.wireName}" must be a '
              'scalar on table "${table.qualifiedName}".',
        );
      }
      if (value is List<Object?> &&
          value.any((item) => item is List || item is Map)) {
        return (
          filters: null,
          error: 'The "in" array must contain only scalar values.',
        );
      }
      filters.add(RowFilter(column: column, operator: operator, value: value));
    }
  }
  return (filters: filters, error: null);
}

({List<RowOrder>? orderBy, String? error}) parseOrderBy(
  Object? raw,
  Set<String> allowedColumns,
) {
  if (raw == null) return (orderBy: const [], error: null);
  if (raw is! List<Object?>) {
    return (orderBy: null, error: '"orderBy" must be an array.');
  }
  final orderBy = <RowOrder>[];
  final seen = <String>{};
  for (final item in raw) {
    if (item is! Map<String, Object?>) {
      return (orderBy: null, error: 'Each "orderBy" entry must be an object.');
    }
    final column = item['column'];
    if (column is! String || !allowedColumns.contains(column)) {
      return (orderBy: null, error: 'Unknown sort column "$column".');
    }
    if (!seen.add(column)) {
      return (orderBy: null, error: 'Duplicate sort column "$column".');
    }
    final direction = switch (item['direction']) {
      'asc' => SortDirection.asc,
      'desc' => SortDirection.desc,
      _ => null,
    };
    if (direction == null) {
      return (orderBy: null, error: 'Sort direction must be "asc" or "desc".');
    }
    orderBy.add(RowOrder(column: column, direction: direction));
  }
  return (orderBy: orderBy, error: null);
}

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
