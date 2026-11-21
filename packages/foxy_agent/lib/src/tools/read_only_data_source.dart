/// SQL aggregate functions exposed by the restricted aggregation tool.
enum AggregateFunction { count, sum, avg, min, max }

/// A fixed aggregate expression; no SQL or caller-supplied alias is accepted.
final class AggregateMetric {
  final AggregateFunction function;

  /// Omitted only for COUNT(*); COUNT(column) counts non-null values.
  final String? column;

  const AggregateMetric({required this.function, this.column});

  String get outputName =>
      column == null ? function.name : '${function.name}_$column';
}

/// Comparison operators supported by row filters.
enum FilterOperator {
  equals('equals'),
  notEquals('notEquals'),
  contains('contains'),
  inList('in'),
  greaterThan('greaterThan'),
  greaterOrEqual('greaterOrEqual'),
  lessThan('lessThan'),
  lessOrEqual('lessOrEqual');

  /// Name used in tool input and error messages.
  final String wireName;

  const FilterOperator(this.wireName);

  /// Parses a wire name; returns `null` when it is unknown.
  static FilterOperator? tryParse(String name) {
    for (final operator in values) {
      if (operator.wireName == name) {
        return operator;
      }
    }
    return null;
  }
}

/// Read-only data access used by the built-in tools.
///
/// Implementations live in the host app and must:
/// - only read and never write;
/// - reject tables and columns outside the catalog allowlist;
/// - return at most the requested limit, with JSON-encodable values.
abstract interface class ReadOnlyDataSource {
  /// Aggregates all matching rows before limiting the returned groups.
  /// Results use group column names and [AggregateMetric.outputName] as keys.
  Future<List<Map<String, Object?>>> aggregateRows({
    required String table,
    required List<RowFilter> filters,
    required List<String> groupBy,
    required List<AggregateMetric> metrics,
    required int limit,
    List<RowOrder> orderBy = const [],
    int offset = 0,
  });

  /// Counts all matching rows in the database, without a row limit.
  Future<int> countRows({
    required String table,
    required List<RowFilter> filters,
  });

  /// Returns rows of [table] matching every filter (logical AND).
  Future<List<Map<String, Object?>>> queryRows({
    required String table,
    required List<RowFilter> filters,
    required int limit,
    List<RowOrder> orderBy = const [],
    int offset = 0,
  });

  /// Reads the connected database's current time and session time zone.
  Future<Map<String, Object?>> serverTime();
}

/// A comparison applied to a single column.
final class RowFilter {
  final String column;

  final FilterOperator operator;

  /// Scalar value to compare against; for [FilterOperator.inList] a non-empty
  /// list of scalars.
  final Object? value;

  const RowFilter({
    required this.column,
    required this.operator,
    required this.value,
  });
}

/// An ordering by a catalog column or an aggregate output name.
final class RowOrder {
  final String column;
  final SortDirection direction;

  const RowOrder({required this.column, required this.direction});
}

enum SortDirection { asc, desc }
